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
    # Introduce configuration specific to this component here.
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

#$survey_config->{glossary_data} = YAML::XS::LoadFile($survey_config->{'conf_dir'}->file('glossary.yaml')->stringify);

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

