package SD::Docker;

use strict;
use warnings;

use Moo;

use LWP::UserAgent;
use LWP::Protocol::http::SocketUnixAlt;
use feature 'say';
use Data::Dumper 'Dumper';
use Carp;
use URI::Encode;
use MIME::Base64;
use Try::Tiny;
use JSON;

$| = 1;

extends 'SD::Docker::Build';

# Override LWP implementation of http communication 
LWP::Protocol::implementor( http => 'LWP::Protocol::http::SocketUnixAlt' );

has user_agent => (
    is => 'rw',
    isa => sub {
        confess "Failed to instantiate user agent"
            unless ref $_[0] eq 'LWP::UserAgent';
    },
    default => sub {
        my $ua = LWP::UserAgent->new;
        $ua->agent("Tempest webbot v1");
        return $ua;
    },
);

has docker_url => (
    is => 'rw',
    default => 'http:/var/run/docker.sock',
);

has docker_repo => (
    is => 'rw',
    default => 'http://localhost:5000',
);

has src_repo => (
    is => 'rw',
);

has error => (
    is => 'rw'
);

has uri => (
    is => 'rw',
    default => sub {
        return URI::Encode->new( { encode_reserved => 0 } );
    },
);

has debug => (
    is => 'rw',
    default => 0,
);

has image_tag => (
    is => 'rw',
);

has image_name => (
    is => 'rw'
);


sub BUILD {
    my $self = shift;
#    $self->user_agent->add_handler( 
#        response_data => sub { 
#            my( $response, $ua, $h, $data ) = @_; 
#            try {
#                my $resp_href = from_json( $data ); 

#                say $resp_href->{status} 
#                    if $resp_href->{status} and $self->debug;
#                    
#            } catch {
#                warn "failed to read JSON line [$data] - $_";
#            }
#        } 
#    );
}

sub push {
    my ( $self ) = @_;

    my $image = $self->uri->encode( $self->docker_repo . '/' . join ( ':', $self->image_name, $self->image_tag ));

    say "Attempting to push $image to " . $self->docker_repo;

    my $return = $self->user_agent->post(
        $self->docker_url . '/' . '/images/' . $image . '/push',
        'Content-Type' => 'text/html',
        'X-Registry-Auth' => encode_base64(qq/
            {
                 "username": "string",
                  "password": "string",
                  "email": "string",
                  "serveraddress": "string"
            }
            /,
        ),
    );

    for my $return_line ( split /\n/, $return->content ) {
        my $resp_href;
        try {
            $resp_href = from_json( $return_line ) 
                or die "failed to parse JSON line [$return_line] - $!"; 
        } 
        catch {
            say STDERR "caught error: $_";
        };

        if ( defined $resp_href->{error} ) {
            $self->error( $resp_href->{error} );
        }
    }

    if ( $return->is_success ) {

        if ( $self->error ) {
            confess "ERROR: " . $self->error;
        } 
        else {
            say 'Image created, tagged and push to the registory';
            #say $return->content;
        }

    } 
    else {
        warn $self->error 
        if $self->error;
        confess $return->status_line;
    }

}

1;
