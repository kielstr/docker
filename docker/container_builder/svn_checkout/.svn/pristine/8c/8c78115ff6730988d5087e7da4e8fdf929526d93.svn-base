package SD::LocustHive;

use Moose;
use JSON::XS;
use LWP::UserAgent;
use HTTP::Request;

use namespace::autoclean;


has cmd => (
    is => 'ro',
);

has env => (
    is => 'ro',
);

has image => (
    is => 'ro',
);

has location => (
    is => 'ro',
);

has cloud_role => (
    is => 'ro',
);

has base_uri => (
    is      => 'ro',
    default => 'http://interact-float.dc.sdlocal.net:5017/',
);

has agent => (
    is => 'ro',
    default => sub { return LWP::UserAgent->new },
);

has auth_key => (
    is      => 'ro',
);

has version => (
    is      => 'ro',
    default => 'v1',
);

has fail_mail => (
    is => 'ro',
);

has pingback => (
    is => 'ro',
);

sub put {
    my ($self, $url, $data) = @_;
    my $request = HTTP::Request->new(
        PUT => $url,
        HTTP::Headers->new(
            'Content-Type' => 'application/json',
        ),
        $data,
    );
    return $self->agent->request($request);
}

sub uri_for {
    my ($self, $action) = @_;
    return $self->base_uri . $self->version . $action;
}

sub _create_json {
    my $self = shift;

    my $data = {
        env        => $self->env,
        cmd        => $self->cmd,
        image      => $self->image,
        location   => $self->location,
        auth_key   => $self->auth_key,
        cloud_role => $self->cloud_role,
    };

    $data->{fail_mail} = $self->fail_mail if $self->fail_mail;
    $data->{pingback}  = $self->pingback  if $self->pingback;

    my $json = encode_json $data;
    return $json;
}


sub run {
    my ($self, $id) = @_;
    my $response = $self->put($self->uri_for('/run'), $self->_create_json);
    return ($response->is_success);
}

__PACKAGE__->meta->make_immutable;

1;
