package SD::Docker::Build;

use strict;
use warnings;
use feature 'say';
use Data::Dumper 'Dumper';
use File::Temp 'tempdir';
use Moo;
use JSON;
use Carp;
use Try::Tiny;
use IO::CaptureOutput qw/capture/;

has temp_dir  => ( is =>'rw' );
has svn_dest => ( is => 'rw' );
has tar_file => ( is => 'rw' );

sub _check_out_repo {
	my ( $self ) = @_;

	say 'Checking out the repo ['. $self->src_repo .'].';
	
	my $svn_cmd = '/usr/bin/svn';
	my $checkout_dest_dir = './svn_checkout';

	$self->temp_dir( tempdir( 'CLEANUP' => 1 ) );

	$self->svn_dest( $self->temp_dir . $checkout_dest_dir );

	chdir $self->temp_dir or confess 'failed to cd into the temp dir: ' . $self->temp_dir . ' ' . $!;

	my ( $stdout, $stderr );
	capture sub { 
		system ( $svn_cmd, ( 'checkout', $self->src_repo, $self->svn_dest ));
	} => \$stdout, \$stderr;

	confess 'failed to check out files ' . $stderr if $stderr;

	say $stdout if $self->debug and $stdout;
}

sub _tar_build_context {
	my ( $self ) = @_;

	my $tar_cmd = '/bin/tar';
	my $tar_filename = 'build_context.tar';

	$self->tar_file( $self->temp_dir . '/' . $tar_filename );

	say 'Building context tar file ['. $self->tar_file .'].';

	chdir $self->svn_dest 
		or confess 'failed to cd into '. $self->svn_dest . ' ' . $!;

	my ( $stdout, $stderr );
	capture sub { 
		system $tar_cmd, ('cvf', $self->tar_file, '.');
	} => \$stdout, \$stderr;

	confess 'failed to tar build context ' . $stderr if $stderr;

	say $stdout if $self->debug and $stdout;
}

sub build_img {
	my ( $self, %options ) = @_;

	say 'Building image.';

	$options{ 'dockerfile' } ||= 'Dockerfile';

	$options{ 't' } ||= ( $self->docker_repo . '/' . join ( ':', $self->image_name, $self->image_tag ) );

	$self->_check_out_repo;

	$self->_tar_build_context;

	open my $tar_fh, '<', $self->tar_file 
		or confess 'failed to open file $tar_file: ' . $!;

	$/ = undef;

	my $tar_contents = <$tar_fh>;

	$tar_fh->close;

	chdir '/container_builder'
		or confess 'failed to cd into /container_builder ' . $!;

	my $query_str = ( $self->docker_url . '//build?' 
		. join ( '&', map { join '=', $_, $options{ $_ } } keys %options )
	);

	my $return = $self->user_agent->post(
	    $query_str,
	    'Content-Type' => 'application/x-tar',
	    Content => $tar_contents,
	);

	unlink $self->tar_file 
		or warn 'Failed to delete tar file ' . $self->tar_file;

	for my $return_line ( split /\n/, $return->content ) {
		my $resp_href;
		try {
			$resp_href = from_json( $return_line ) 
				or die "failed to parse JSON line [$return_line] - $!"; 
		} catch {
			warn "caught error: $_";
		};

		if ( defined $resp_href->{message} ) {
			$self->error( $resp_href->{message} );
		}
	}

	if ( $return->code == 500 ) {
		warn $self->error 
			if $self->error;

		confess 'Server Error: ' . $return->status_line;
	} elsif ( $return->code == 400 ) {

		warn $self->error 
			if $self->error;

		confess 'Bad parameter: ' . $return->status_line;
		
	} elsif  ( $return->is_success ) {
		say $return->content if $self->debug;
	} else {

		warn $self->error 
			if $self->error;

		confess $return->status_line;
	}
}

1;
