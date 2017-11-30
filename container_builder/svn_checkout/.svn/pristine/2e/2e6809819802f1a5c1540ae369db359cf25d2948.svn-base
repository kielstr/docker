package SD::PrinceXML::Client;
use 5.008;
use Moose;
use Moose::Util::TypeConstraints;
use SD::Platform 0.62; # First version to support SD_PRINCEXML_URL
use Carp;
use LWP::UserAgent;
use Path::Class;
use HTML::TokeParser::Simple;
use URI;
use Encode;
our $VERSION = '13';


########################################################################
has 'webservice' => (
    is => 'rw',
    isa => 'Str',
    default => sub { SD::Platform->princexml_url }
);

has 'filename' => (is => 'rw', isa => 'Str', default => 'document.pdf');

has 'strict' => (is => 'rw', isa => 'Bool', default => 0);

has 'network' => (is => 'rw', isa => 'Bool', predicate => '_has_network');

has 'input' => (is => 'rw',
                isa => enum([qw{auto html xml}]),
                default => 'auto');

has 'data' => (is => 'rw', isa => 'Str', predicate => '_has_data',
               trigger => sub { (shift)->_reset('data', @_); },
               predicate => '_has_data',
               clearer   => '_clear_data');

has 'url' => (is => 'rw', isa => 'Str', predicate => '_has_url',
              trigger => sub { (shift)->_reset('url', @_); },
              predicate => '_has_url',
              clearer   => '_clear_url');

has 'send_literal_url' => (is => 'rw', isa => 'Bool', default => 0);

has 'ua' => (is => 'ro', isa => 'LWP::UserAgent', lazy => 1,
             default => sub { LWP::UserAgent->new(env_proxy => 1) });

has 'baseurl' => (is => 'rw', isa => 'Str',
                  predicate => '_has_baseurl',
                  clearer   => '_clear_baseurl');

# Store the extra files to send to the server.
has '_extra' => (is => 'rw', isa => 'ArrayRef', clearer => '_clear_extra', predicate => '_has_extra');

########################################################################
sub _reset {
    my ($self, $set, $new) = @_;
    return if !defined($new);   # return if clearing...

    # The attributes we watch...
    my $badness = undef;
    if ($set eq 'url') {
        if ($self->_has_data) {
            $self->_clear_data;
            $badness = 'data';
        }
    } elsif ($set eq 'data') {
        if ($self->_has_url) {
            $self->_clear_url;
            $badness = 'url';
        }
    } else {
        die("Unknown _reset argument: '$set'");
    }

    if ($badness) {
        carp "Setting ${set} while ${badness} is set clears the older attribute\n";
    }

    return $new;
}


sub pdf {
    my $self = shift;
    my $filename = $self->filename;
    my $htmlname = $filename; $htmlname =~ s/\.pdf$/.html/;

    # Check sanity.
    croak('You must set one of the content attributes before calling pdf')
        unless $self->_has_data or $self->_has_url;

    # Construct the POST request...
    my $form = [ '_submitted_princexml' => 1,
                 'output' => $filename,
                 'input'  => $self->input ];

    push @$form, strict => 'strict' if $self->strict;
    push @$form, baseurl => $self->baseurl if $self->_has_baseurl;
    push @$form, network => 'permit' if $self->_has_network and $self->network;

    if ($self->_has_data) {
        push @$form, 'input-source' => 'file';
        push @$form, 'htmlfile' => [undef, $htmlname,
                                    Content_Type => 'text/html; charset=UTF-8',
                                    Content => encode('utf-8', $self->data)];
        for my $extra (@{ $self->_extra || [] }) {
            push @$form, 'extrafile' => $extra;
        }
    } elsif ($self->_has_url) {
        if ($self->send_literal_url) {
            push @$form, 'input-source' => 'url';
            push @$form, 'url' => $self->url;
        } else {
            push @$form, 'input-source' => 'file';
            $self->_attach_data_from_url($form);
        }
    }
    # NOTE: If css/images arent being uploaded
    #       for URL -> uncomment this.
    if ($self->_has_extra) {
        for my $extra (@{ $self->_extra || [] }) {
            push @$form, 'extrafile' => $extra;
        }
    }

    my $r = $self->ua->post($self->webservice,
                            Content_Type => 'form-data',
                            Content => $form);

    # Handle errors -- first, HTTP level failures.
    unless ($r->is_success) {
        croak("Failed to render PDF: HTTP communication error\n", $r->status_line);
    }

    # Next, PrinceXML rendering errors.
    my $ct = $r->content_type;
    if (my $ref = ref($ct)) {
        die("content type header had unknown reftype [$ref]")
            unless $ref eq 'ARRAY';
        $ct = $ct->[0];         # the type, not the annotations.
    }
    if ($ct ne 'application/pdf') {
        croak("Failed to render PDF: errors from PrinceXML\n",
              $r->decoded_content,
              $r->content_type eq 'text/plain' ? undef : ("\n" . $r->content_type));
    }

    # Well, everything worked.  Return the PDF content, after decoding any
    # content transfer encoding or whatever, just in case...
    return $r->decoded_content();
}


sub add_extra_file {
    my ($self, $filename, $data) = @_;
    croak("No file given when adding extra file") unless $filename;

    # Build up the form data we submit for this extra file.
    # Allow the content type to be guessed by LWP.
    my $formdata = [ defined($data) ? undef : $filename, # where to read from
                     file($filename)->basename];         # filename to upload

    # Add the raw bytes, if supplied.
    if (defined($data)) {
        push @$formdata, Content => $data;
    } else {
        croak("unable to read $filename: $!") unless -r $filename;
    }

    # Finally, append that to the internal data structure.
    $self->_extra([ @{ $self->_extra || [] }, $formdata ]);
    map { die("got ", ref($_), " not ARRAYREF") unless ref($_) eq 'ARRAY' } @{$self->_extra};
    return 1;
}


sub clear {
    my $self = shift;
    $self->_clear_data;
    $self->_clear_url;
    $self->_clear_extra;
    $self->_clear_baseurl;
    return 1;
}



sub _attach_data_from_url {
    my ($self, $form) = @_;

    # First, we fetch the HTML content, then process it to attach extra files
    # as we rewrite the links to be relative...
    my ($htmlname, $html) = $self->_fetch($self->url);

    # Now, we rewrite that and attach the extra files as we go.
    my $parser = HTML::TokeParser::Simple->new(string => $html);
    my $baseurl = URI->new($self->url);
    my $unique = 1;             # to ensure unique filenames...
    my $rewritten = '';         # rewritten HTML content

    while (my $token = $parser->get_token) {
        if ($token->is_tag('img') and my $src = $token->get_attr('src')) {
            # Now, we fetch that content.  This uses the full UA, not simple.
            my ($filename, $data) = $self->_fetch($baseurl, $src);

            # Ensure that the filename is unique within reasonable limits; we
            # just prefix it with a number that increments for every file,
            # which means that there isn't much scope for a clash, anywhere.
            $filename = sprintf('%05d-%s', $unique++, $filename);

            # Add the data to the prince client.
            $self->add_extra_file($filename => $data);

            # Finally, we rewrite the source attributes...
            $token->set_attr(src => $filename);
        } elsif ($token->is_tag('link') and my $href = $token->get_attr('href')) {
            # Get the 'rel' attribute.
            my $rel = $token->get_attr('rel') || '';
            # Exclude rel='Meta' link tags
            # REVISIT: Are there any other <link rel='XXX'> tags we should ignore?
            if ( lc $rel ne 'meta') {
                my ($filename, $bytes) = $self->_fetch($baseurl, $href);

                # Ensure that the filename is unique within reasonable limits; we
                # just prefix it with a number that increments for every file,
                # which means that there isn't much scope for a clash, anywhere.
                $filename = sprintf('%05d-%s', $unique++, $filename);

                # Add the data to the prince client.
                $self->add_extra_file($filename => $bytes);

                # Finally, we rewrite the source attributes...
                $token->set_attr(href => $filename);
            }
        } elsif ($href = $token->get_attr('href')) {
            # Rewrite the generic HREF attribute to an absolute URL.
            $token->set_attr('href', URI->new_abs($href, $baseurl)->as_string);
        }

        $rewritten .= $token->as_is;
    }

    # Add the HTML content to the form...
    # Encoding to utf8 bytes if necessary
    push @$form, 'htmlfile' => [
        undef, $htmlname,
        Content_Type => 'text/html' . utf8::is_utf8( $rewritten ) ? '; charset=UTF-8' : '',
        Content => utf8::is_utf8( $rewritten) ? encode( 'utf-8', $rewritten ) : $rewritten
    ];

    return 1;
}

sub _fetch {
    my ($self, $baseurl, $relative) = @_;

    my $url = $relative ? URI->new_abs($relative, $baseurl) : URI->new($baseurl);
    my $response = $self->ua->get($url);
    die("Unable to fetch $url: undef response") unless $response;
    die("Unable to fetch $url: " . $response->status_line)
        unless $response->is_success;

    # Now, determine the filename...
    my $filename = (file($url->path)->basename || 'index.html');
    return ($filename, $response->decoded_content);
}


1;
__END__

=head1 NAME

SD::PrinceXML::Client - wrap the PrinceXML webservice API for local use.

=head1 SYNOPSIS

    my $pdf = eval { SD::PrinceXML::Client->new(data => $html)->pdf; };
    if ($@) {
        print "Failed to generate PDF: $@";
    }

=head1 DESCRIPTION

This package provides a light, object oriented wrapper around the
SD::PrinceXML::WebService system, allowing trivial access to the remote API
without needing to fiddle with the details of the form or related modules by
hand.

=head1 ATTRIBUTES

=over

=item B<baseurl>

The base URL to supply to prince while rendering.  This is used with relative
URL values to calculate the final URL location.  This generally only makes
sense when combined with a B<data> source rather than a B<url> source.

=item B<data>  (I<source>)

Inline content to render to PDF; this must be in HTML format.

=item B<filename>

The output filename; this is mostly ignored at this stage as we only return
content inline, and this only alters content meta-data which we discard.

=item B<input>

The input format; the defaults to C<auto>, which is usually the right option.
C<html> and C<xml> force HTML or XML processing mode for the prince(1)
process.

=item B<network>

Allow network access.  This is forcibly enabled if a URL source is given, but
otherwise controls the ability of prince(1) to fetch CSS and images via the
network.

=item B<strict>

Enable strict PDF processing mode; when enabled any errors or warnings in the
PDF will cause generation failure, rather than only truly fatal errors.

=item B<ua>

The L<LWP::UserAgent> instance to use for accessing the webservice.  If not
supplied then a new user agent will be created and cached in the object.

=item B<url>  (I<source>)

The URL to render as PDF; this will be fetched by the prince(1) binary, not
the client module; if this is not accessible to the webserver then you need to
use the B<data> attribute instead.

=item B<send_literal_url>  (default: I<false>)

If true, send the literal URL to the webservice.  Otherwise the client module
will fetch the URL provided and upload all the content from your application.

This does take into account the various URL types that occur in the content
and which need to be managed on the way to the server.

This is the default as it is more robust to use local DNS rather than
server-side DNS to fetch and manage the content.

=item B<webservice>

The URL for the PrinceXML web service.  This is sourced from SD::Platform's
SD_PRINCEXML_URL variable.

=back

=head1 METHODS

=over

=item B<pdf> ()

Return the PDF content generated by the web service, or die with an
appropriate error message if generation fails.

You must have set one of the content source attributes when you call this
method, or an exception will be thrown.

=item B<add_extra_file> (I<filename>, [I<data>))

Add an extra "file" to be sent to the PrinceXML web service.  This can be a
file on disk, or a stream of bytes; the I<data> member, if supplied, is
treated as the file content.

When I<data> is not present the file I<filename> is not uploaded until the
C<pdf> method is called, to ensure that large files do not bloat the core Perl
image at runtime.

When I<data> is present the I<filename> is used as the filename to send with
the data, and is typically the name of the expected file for the client.

    # Load the image file from disk when C<pdf> is called.
    $client->add_extra_file('t/test.png');

    # Load the image file from the database at the current time.
    $client->add_extra_file('test.png', image_from_db(...));

=item B<clear> ()

Clear all source attributes, and removes any extra files attached.

=back

=head1 DIAGNOSTICS

=over

=item You must set one of the content attributes before calling pdf

You need to set the data source for the object to convert before calling the
pdf method.  At this stage, that means that the I<data> attribute must be set.

=item Failed to render PDF: I<reason> I<detail>

Rendering the PDF via the PrinceXML API failed; I<reason> gives more detail on
where the failure occurred, and I<detail> contains any detailed error
messages.

=back

=head1 AUTHOR

Daniel Pittman <support@strategicdata.com.au>

=head1 COPYRIGHT and LICENSE

Copyright 2008,2014, Strategic Data.  All Rights Reserved.

This module is free software and can be distributed under the same terms as
Perl itself.

