#######################################################################
#                                                                     #
#                 . '@(@@@@@@@)@. (@@) `  .   '                       #
#       .  @@'((@@@@@@@@@@@)@@@@@)@@@@@@@)@                           #
#       @@(@@@@@@@@@@))@@@@@@@@@@@@@@@@)@@` .                         #
#    @.((@@@@@@@)(@@@@@@@@@@@@@@))@\@@@@@@@@@)@@@  .                  #
#   (@@@@@@@@@@@@@@@@@@)@@@@@@@@@@@\\@@)@@@@@@@@)                     #
#  (@@@@@@@@)@@@@@@@@@@@@@(@@@@@@@@//@@@@@@@@@) `                     #
#   .@(@@@@)##&&&&&(@@@@@@@@)::_=(@\\@@@@)@@ .   .'                   #
#     @@`(@@)###&&&&&!!;;;;;;::-_=@@\\@)@`@.                          #
#     `   @@(@###&&&&!!;;;;;::-=_=@.@\\@@     '                       #
#        `  @.#####&&&!!;;;::=-_= .@  \\                              #
#              ####&&&!!;;::=_-        `                              #
#               ###&&!!;;:-_=                                         #
#                ##&&!;::_=                                           #
#               ##&&!;:=                                              #
#              ##&&!:-                                                #
#             #&!;:-           This component is managed by Tempest.  #
#            #&!;=         Please only use Tempest to manipulate it.  #
#            #&!-                                                     #
#    _____    #&=        If you need to explicitly modify this file,  #
#   /\____\    #&-         please file a Tempest enhancement ticket.  #
#   | |" "|    \\#/'                                                  #
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #
#######################################################################

use strict;
use warnings;

use SD::WebSurvey::StockComponentConfig ();

my %conf = (
    send_completion_email => sub {
      my $session = shift;
      my $config  = SD::Config->load;
      my $json    = JSON::XS->new;

      my $external_data_consent_session_key = $config->{create_external_data_consent_survey}->($session);

      my $consent_config = $config->{get_component_config}->('external-data-consent');
      my $consent_url    = $consent_config->{webserver_info}->{fe_url};

      # Figure out the vars we need.
      my %vars = (
        name          => $session->get('firstname'),
        consent_link  => "$consent_url/q?SD_KEY=$external_data_consent_session_key",
      );

      # Low patients get a list of resources emailed to them, attached as pdf
      my @download_attachments;
      my @attachments = (
        'static/link-me/Additional_Resources.pdf',
        'static/link-me/Link-me_And_Your_Health_Service_Use_Information_Sheet.pdf',
        'static/link-me/Link-me_Study_Information.pdf',
      );

      my $group    = $session->get('group');
      my $severity = $session->get('severity');

      my $template;
      if ($group eq 'control') {
        $template = 'link_me_control.tx';
      } elsif ($severity =~ m/^Severe/) {
        $template = 'link_me_patient_high.tx';
      } else {
        my $survey_config = $config->{get_component_config}->('survey');
        my $survey_url    = $survey_config->{webserver_info}->{fe_url};

        push @download_attachments, "$survey_url/resources_pdf.tt2?SD_KEY=" . $session->get('session_key');
        $template = 'link_me_patient_low.tx';
      }

      $config->{send_email}->(
        $session->get('email'), # to
        undef, # cc
        'Your Link-me resources', # subject
        $template, # template
        $json->encode(\%vars), # vars
        $json->encode(\@attachments), # attachments
        $json->encode(\@download_attachments), # attachments to download
      );

    },

    create_external_data_consent_survey => sub {
      my $session = shift;

      my $config = SD::Config->load;
      my $json   = JSON::XS->new;

      my $session_key = $session->get('session_key');
      my $external_data_consent_session_key = $config->{find_session}->('external-data-consent', parent_session => $session_key);

      if (!$external_data_consent_session_key) {
        my $external_data_consent_session = $config->{create_component_session}->('external-data-consent');
        $external_data_consent_session->set(parent_session => $session_key);
        $external_data_consent_session->set(created => time());
        #XXX: Do we need more info? Maybe?

        $external_data_consent_session_key =  $external_data_consent_session->get('session_key');
      }

      return $external_data_consent_session_key;
    },

    send_email => sub {
        my ($to, $cc, $subject, $template, $vars, $attachments, $download_attachments) = @_;

        my $ws_config = SD::Config->load;
        my @env = (
            "EMAIL_TO=$to",
            "EMAIL_CC=$cc",
            "EMAIL_FROM=On behalf of Link-me",
            "EMAIL_SUBJECT=$subject",
            "EMAIL_TEMPLATE=$template",
            "EMAIL_VARS=$vars",
            "EMAIL_ATTACHMENTS=$attachments",
            "EMAIL_DOWNLOAD_ATTACHMENTS=$download_attachments",
        );

        $ws_config->{run_ws_tools}->('send-email-with-attachments', \@env);
    },
    run_ws_tools => sub {
        my ($cmd, $env) = @_;

        my $ws_config = SD::Config->load;
        my $lh_config = $ws_config->{locust_hive_config}->();

        $lh_config->{env} = $env;
        # cmd must be an arrayref..
        $lh_config->{cmd} = ref ($cmd) eq 'ARRAY' ? $cmd : [$cmd];

        SD::LocustHive->new($lh_config)->run;
    },
    locust_hive_config => sub {
        my $image  = 'docker.sdlocal.net/websurvey/tools';
        my $digest = 'sha256:943d0a6698c567c71c7bd34bf5ac1317540ae59d5b0a0d6f6d55dce4674a583c';

        return {
            auth_key   => 'd349c737-9210-48ee-ba76-d51de696062d',
            image      => $image.'@'.$digest,
            cloud_role => 'compute',
            location   => 'globalcenter',
            fail_mail  => 'ash@strategicdata.com.au',
        };
    },
);

#
# Upload file path, uncomment if you need to extract files from the survey
#$conf{'upload_dir'} = '/tmp';

# What's below is not (meant to be) user servicable..
# The data structure returned by SD::WebSurvey::StockComponentConfig
# should be regarded as immutable unless you really know what you're doing.
#
my $static_html_overridden = exists $conf{'static_html'}; # Merge dirties %conf
# Merge %conf with SCC and global_defaults
my $survey_config = SD::WebSurvey::StockComponentConfig->conf( %conf );

$survey_config->{glossary_data} = YAML::XS::LoadFile($survey_config->{'conf_dir'}->file('glossary.yaml')->stringify);
$survey_config->{resource_data} = YAML::XS::LoadFile($survey_config->{'conf_dir'}->file('resources.yaml')->stringify);
$survey_config->{gps} = YAML::XS::LoadFile($survey_config->{'conf_dir'}->file('gps.yaml')->stringify);

# Inject appropriate paths to websurvey-templates versions.
if ( exists $survey_config->{'template_version'}
     && $survey_config->{'template_version'} =~ m/^\d+$/ ) {
    # Adjust survey_static to pull in appropriate version of static files unless
    # this was specified in %conf
    $survey_config->{'static_html'} = sprintf(
        '/usr/share/websurvey-templates/%03d/static', $survey_config->{'template_version'})
        unless $static_html_overridden;
    # Adjust tt_inc, splicing appropriate version into tt_inc (before last element)
    splice( @{$survey_config->{tt_inc} }, -1 , 0,
        sprintf('/usr/share/websurvey-templates/%03d/tt2', $survey_config->{'template_version'}));
}

# Find 'default' survey - either by name (path) or surveymeta if it exists.
my $default = 'default';
if ( exists $survey_config->{surveymeta} ) {
    $default = $survey_config->{surveymeta}{components}{default};
}


my $survey_base = $survey_config->{'conf_dir'}->parent;
$survey_config->{survey_html} = $survey_base->parent->subdir($default,'html')->stringify;
unshift @{$survey_config->{tt_inc}}, $survey_base->parent->subdir($default,'tt2')->stringify;
unshift @{$survey_config->{tt_inc}}, $survey_base->subdir('tt2')->stringify;

local @INC = ($survey_config->{'conf_dir'}->parent->subdir('lib')->stringify, @INC);
require SD::LocustHive;

# Merge common.pl contents (typically subs for session manipulation)
# This WILL overwrite existing keys. Uncomment if needed.
my $common_pl = SD::Config->load( $survey_base->parent->subdir($default,'conf')->file('common.pl')->stringify );
@$survey_config{ keys %$common_pl } = values %$common_pl;

# Do what we must to 'close' a survey.
if ( $survey_config->{close} ) {
    $survey_config->{get_session}->{SessionFrom} = 'Login';
    $survey_config->{index_page} = 'close.tt2';
    $survey_config->{authenticate}->{LoginForm} = 'close.tt2';
}

# All done.
return $survey_config;
