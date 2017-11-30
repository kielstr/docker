#!perl -Ilib -w -I.
# GENERATED FILE  GENERATED FILE  GENERATED FILE  GENERATED FILE
# ws-y2p content.yaml | perl
# ws-y2p content.yaml | nl | m
# perl -MYAML -Ilib -e 'print Dump do +shift' content.pl

use utf8;
use strict;
# WARNING, if these modules aren't found in @INC do will return ''
use SD::Slot;
use SD::Page;
use WS::Page::Switch;
use Data::Rmap qw(rmap_hash cut);

my %slots;
my %pages;

# auxillary scripts can keep ordered hash (ws-allpages ws-export)
# (TT2 may need $Template::Config::STASH = 'Template::Stash'; )
if($ENV{SD_CONTENT_ORDERED}) {
    eval 'use Tie::IxHash';
    tie %pages, 'Tie::IxHash';
}



# -----SLOTS----- $slot_code output:

$slots{'yes_no'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'yes_no',
  'options' => [
    'Yes',
    'No'
  ],
  'widget' => 'choice_v',

};
}});
$slots{'understanding_emotional'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => '<p><strong>UNDERSTANDING EMOTIONAL HEALTH AND WELLBEING</strong><br/>
One of the goals of Link-me care navigation is to provide you with information about how to manage your emotional health and wellbeing. Do you feel like you have all the information you need?</p>
<p>If not, what else would you like to know or like me to follow-up?</p>
'
  },
  'name' => 'understanding_emotional',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'tree'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'tree',
  'widget' => 'org_tree_expand',
  'check' => sub {
   my ($self, $item) = @_;
   unless($item =~ /^\d+$/ && $item >= 1 && $item <= scalar @{ $self->options } ){
       die E->new("Not one of allowed responses");
   }
   return 1;
},
  'options' => sub {
  my $self = shift;
  use Data::Rmap qw/:all/;
  return [ rmap_to {
    return cut( $_->{text} ) if (ref $_ eq 'HASH');
    return $_ unless ref $_;
    return shift->recurse;
  } HASH|ARRAY|VALUE, @{$self->tree} ];
},

};
}});
$slots{'risk_assessment'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'text' => '<p><strong>RISK ASSESSMENT</strong><br/>
The Link-me iPad survey asked you how often you had been bothered by thoughts about hurting yourself.</p>
[% patient_session = conf.fetch_session(session.get(\'survey_session_key\'), \'survey\'); phq9 = patient_session.get(\'phq9\'); %]
<p>You answered <strong>[% conf.get_component_config(\'survey\').pages.PAGE_009C.slot(\'phq9\').perdy_value(phq9) %]</strong>. Has this changed at all since then?</p>
',
    'tt2' => 1
  },
  'name' => 'risk_assessment',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'ranking'} = SD::Slot::record->new(do {{
my $VAR1 = {
  'name' => 'ranking',
  'mandatory' => sub {
  my $self = shift;
  return 1 unless defined $_[0];
  return ! $self->normalize(@_);
},
  'normalize' => sub {
  my( $self, $val ) = @_;
  my %val_counts;
  for my $slt ( @{ $self->columns } ) {
    next if ! exists $val->{ $slt->name }; # Should this be var_name
    my $v = $val->{ $slt->name };
    next if (! defined $v || $v =~ /^\s*$/);
    if ( $val_counts{$v}++ ) {
      die E->new("More than one criterion has the same ranking ($v)");
    }
  }
  unless ( scalar keys %val_counts == $self->columns->[0]->max_val ) {
    die E::Skip->new("You must rank the criterion from ".
      $self->columns->[0]->min_val." to ".$self->columns->[0]->max_val );
  }
  return 1;
},

};
}});
$slots{'provisional_diagnosis'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'html' => 1,
    'text' => '<p><strong>PROVISIONAL DIAGNOSIS</strong><br/>
Based on his/her knowledge of your current issues, your GP thinks  you are most likely experiencing a(n):</p>
'
  },
  'name' => 'provisional_diagnosis',
  'options' => [
    'Anxiety disorder',
    'Mood disorder',
    'Substance use disorder',
    'Psychotic disorder',
    'A disorder with onset usually occurring in childhood and adolescence not listed elsewhere',
    'Other mental disorder',
    'No formal mental disorder but sub-syndromal problem'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'phone_check'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'consent',
  'max_val' => 9999999999,
  'min_val' => 0,
  'name' => 'phone_check',
  'check' => sub {
  my $self = shift;
  $self->super(@_);

  if ($self->exists(@_)) {
    die E->new("Phone number already exists");
  }

  my $val = shift;

  my $area_code = substr($val, 0, 2);
  # Converting international prefix of 61 to 0
  my $new_number;
  if ($area_code == "61") {
    $new_number = substr($val, 0, 2, "0");
    $area_code  = substr($val, 0, 2);
  }
  my $length = length($val);
  if ( ($length < 10) || ($length > 10) ) {
    die E->new( "The mobile phone number supplied is incorrect, must be 10 digits" );
  }
  return 1;
},

};
}});
$slots{'mc_v'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_v',
  'widget' => 'choice_v',
  'check' => sub {
    my ($slot, $value)  = @_;
    my %answer          = map {$_ => 1} @{$value};
    my $text_value;
    my $open_value;
    if ( defined $slot->open ) {
      foreach (@{$value}) {
        if (/\D/ || $_ >= @{$slot->options}) {
          $text_value += 1;
        }
      }
      foreach (@{$slot->open}) {
        if (exists $answer{$_}) {
          $open_value += 1;
        }
      }
      if ($text_value != $open_value) {
        die E->new( "A response is required" );
        return 0;
      }
      return 1;
    } else {
      return 1;
    }
  },

};
}});
$slots{'mc_h'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_h',
  'widget' => 'choice_h',

};
}});
$slots{'making_work'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => "<p><strong>MAKING IT WORK</strong><br/>
Can you think of any signs that might mean you need extra support to improve your emotional health and wellbeing?</p>
<p>Who do you think you could talk to if you felt like you needed extra help?</p>
<p>What have you done in the past to help you manage when you\x{2019}re going through an especially hard time?</p>
<p>(If you like, I can provide some suggestions about supports that other people have found useful)</p>
"
  },
  'name' => 'making_work',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'k10_scale'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'k10_scale',
  'options' => [
    'None of the time',
    'A little of the time',
    'Some of the time',
    'Most of the time',
    'All of the time'
  ],
  'widget' => 'choice_v',

};
}});
$slots{'email_check'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'input_type' => 'email',
  'name' => 'email_check',
  'size' => 80,
  'widget' => 'textfield',
  'check' => sub {
  my $self = shift;

  if ($self->exists(@_)) {
    die E->new("Email already exists");
  }
  # Normalize
  my $email = Email::Valid->address( -address => lc $_[0], -mxcheck => 1 );
  if ( ! $email ) {
    die E->new( "You must supply a valid email address (not $_[0])" );
  }
  $_[0] = $email;
  return !! $email;
},

};
}});
$slots{'difficult2_review_progress'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'text' => "<p><strong>REVIEWING PROGRESS</strong><br/>
How have you been going with the actions you planned to take?</p>
<p>How have the actions you\x{2019}ve taken so far been helpful?</p>
<p>What have been some of the difficulties in making changes to improve your [% conf.intervention_areas.\$second.sentence_text %]?</p>
<p>What steps might be helpful to overcome these difficulties?</p>
<p>Do you need any additional information or support?</p>
",
    'tt2' => 1
  },
  'name' => 'difficult2_review_progress',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_resource_2_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult2_resource_2_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_resource_2'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'RESOURCES 2',
  'name' => 'difficult2_resource_2',
  'options' => [
    'Online',
    'App',
    'Self-help',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_resource_1_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult2_resource_1_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_resource_1'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'RESOURCES 1',
  'name' => 'difficult2_resource_1',
  'options' => [
    'Online',
    'App',
    'Self-help',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_referral_2_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult2_referral_2_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_referral_2'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'REFERRAL 2',
  'name' => 'difficult2_referral_2',
  'options' => [
    'Psychologist',
    'Psychiatrist',
    'Social worker',
    'Exercise physiologist',
    'Dietitian',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_referral_1_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult2_referral_1_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_referral_1'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'REFERRAL 1',
  'name' => 'difficult2_referral_1',
  'options' => [
    'Psychologist',
    'Psychiatrist',
    'Social worker',
    'Exercise physiologist',
    'Dietitian',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_achieve_what'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => "<p><strong>WHAT I WANT TO ACHIEVE</strong><br/>
What kinds of things are important to you, which are affected by your problems in this area?</p>
<p>What would you like to be doing, that you\x{2019}re finding difficult at the moment because of these issues?</p>
<p>(If you like, I can provide some suggestions that other people have found useful)</p>
<p>What do you think you would you like to focus on?</p>
"
  },
  'name' => 'difficult2_achieve_what',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult2_achieve_how'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => '<p><strong>HOW I WANT TO ACHIEVE IT</strong><br/>
What ideas do you have for how you could work towards achieving your goals?</p>
<p>What do you know about the options that are available to help</p>
<p>(If you like, I can provide some suggestions that other people have found useful)</p>
<p>What action(s) would you be most comfortable and confident with taking?</p>
'
  },
  'name' => 'difficult2_achieve_how',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_review_progress'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'text' => "<p><strong>REVIEWING PROGRESS</strong><br/>
How have you been going with the actions you planned to take?</p>
<p>How have the actions you\x{2019}ve taken so far been helpful?</p>
<p>What have been some of the difficulties in making changes to improve your [% conf.intervention_areas.\$first.sentence_text %]?</p>
<p>What steps might be helpful to overcome these difficulties?</p>
<p>Do you need any additional information or support?</p>
",
    'tt2' => 1
  },
  'name' => 'difficult1_review_progress',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_resource_2_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult1_resource_2_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_resource_2'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'RESOURCES 2',
  'name' => 'difficult1_resource_2',
  'options' => [
    'Online',
    'App',
    'Self-help',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_resource_1_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult1_resource_1_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_resource_1'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'RESOURCES 1',
  'name' => 'difficult1_resource_1',
  'options' => [
    'Online',
    'App',
    'Self-help',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_referral_2_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult1_referral_2_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_referral_2'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'REFERRAL 2',
  'name' => 'difficult1_referral_2',
  'options' => [
    'Psychologist',
    'Psychiatrist',
    'Social worker',
    'Exercise physiologist',
    'Dietitian',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_referral_1_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other\', please specify',
  'name' => 'difficult1_referral_1_other_specify',
  'size' => 70,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_referral_1'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'REFERRAL 1',
  'name' => 'difficult1_referral_1',
  'options' => [
    'Psychologist',
    'Psychiatrist',
    'Social worker',
    'Exercise physiologist',
    'Dietitian',
    'Other (specify)'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_achieve_what'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => "<p><strong>WHAT I WANT TO ACHIEVE</strong><br/>
What kinds of things are important to you, which are affected by your problems in this area?</p>
<p>What would you like to be doing, that you\x{2019}re finding difficult at the moment because of these issues?</p>
<p>(If you like, I can provide some suggestions that other people have found useful)</p>
<p>What do you think you would you like to focus on?</p>
"
  },
  'name' => 'difficult1_achieve_what',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'difficult1_achieve_how'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => '<p><strong>HOW I WANT TO ACHIEVE IT</strong><br/>
What ideas do you have for how you could work towards achieving your goals?</p>
<p>What do you know about the options that are available to help</p>
<p>(If you like, I can provide some suggestions that other people have found useful)</p>
<p>What action(s) would you be most comfortable and confident with taking?</p>
'
  },
  'name' => 'difficult1_achieve_how',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'db_upload'} = SD::Slot::upload->new(do {{
my $VAR1 = {
  'name' => 'db_upload',
  'store_class' => 'SD::Slot::Upload::Store::Database',

};
}});
$slots{'datepicker'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'class' => 'datepicker',
  'name' => 'datepicker',
  'widget' => 'datepicker',

};
}});
$slots{'completing_gp'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => '<p><strong>COMPLETING THE PLAN WITH YOUR GP</strong></p>
<p><strong>MENTAL STATE EXAMINATION</strong></p>
'
  },
  'name' => 'completing_gp',
  'rows' => 4,
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'offered_plan'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold-options',
  'name' => 'offered_plan',
  'options' => [
    'Been offered a copy of this plan to keep?'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'developed_action_plan'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold-options',
  'name' => 'developed_action_plan',
  'options' => [
    'Developed an action plan and set a date for review?'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'chance_talk_yourself'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold-options',
  'label' => 'Have you:',
  'name' => 'chance_talk_yourself',
  'options' => [
    'Had a chance to talk about yourself, your treatment experience and preferences, and your emotional health and wellbeing?'
  ],
  'default' => sub {
  my ($slot, $session) = @_;
  my $conf         = SD::Config->load;
  my $last_session = $conf->{fetch_session}->($session->get('last_action_plan'), 'action-plan');
  return $last_session ? $last_session->get($slot->name) : "";
},

};
}});
$slots{'c_h'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_h',
  'widget' => 'choice_h',

};
}});



# -----PAGES----- $page_code output:
$pages{'start'} = SD::Page->new(do {{
my $VAR1 = {
  'first' => 0,
  'name' => 'start',
  'nav' => [
    {
      'next' => 'Next'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'prev' => 0,
    'show' => 1
  },
  'percent' => 0,
  'portal' => 'redirect_to_admin',
  'prev' => 0,
  'qns' => [
    {
      'heading' => 'Action plan'
    },
    {
      'text' => '[% PROCESS \'crud-summary-header\' IF summary_view %]',
      'tt2' => 1
    },
    {
      'text' => '[% patient_session = conf.fetch_session(session.get(\'survey_session_key\'), \'survey\'); areas_of_difficulty = patient_session.get(\'q2\'); first = areas_of_difficulty.first; second = areas_of_difficulty.last; %]
<h2><strong>[% conf.intervention_areas.$first.sentence_text %]</strong></h2>
',
      'tt2' => 1
    },
    {
      'slot' => 'difficult1_achieve_what'
    },
    {
      'slot' => 'difficult1_achieve_how'
    },
    {
      'html' => 1,
      'text' => '<strong>AGREED ACTION</strong>'
    },
    {
      'rows' => [
        [
          {
            'slot' => 'difficult1_referral_1'
          },
          {
            'slot' => 'difficult1_referral_1_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult1_resource_1'
          },
          {
            'slot' => 'difficult1_resource_1_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult1_referral_2'
          },
          {
            'slot' => 'difficult1_referral_2_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult1_resource_2'
          },
          {
            'slot' => 'difficult1_resource_2_other_specify'
          }
        ]
      ],
      'widget' => 'multi_textbox_table'
    },
    {
      'slot' => 'difficult1_review_progress'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $config = SD::Config->load;
  my $patient_session = $config->{fetch_session}->($session->get('survey_session_key'), 'survey');

  my $difficult_areas = $patient_session->get('q2');
  my $number_of_areas = @$difficult_areas;

  if ($number_of_areas < 2) {
    return 'PAGE_care_nav_action_3_last';
  }

  return 'PAGE_care_nav_action_2';
},

};
}});
$pages{'PAGE_care_nav_action_2'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_action_2',
  'nav' => [
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'prev' => 1,
    'show' => 1
  },
  'next' => 'PAGE_care_nav_action_3_last',
  'percent' => 20,
  'portal' => 'redirect_to_admin',
  'prev' => 'start',
  'qns' => [
    {
      'heading' => 'Action plan'
    },
    {
      'text' => '[% patient_session = conf.fetch_session(session.get(\'survey_session_key\'), \'survey\'); areas_of_difficulty = patient_session.get(\'q2\'); first = areas_of_difficulty.first; second = areas_of_difficulty.last %]
<h2><strong>[% conf.intervention_areas.$second.sentence_text %]</strong></h2>
',
      'tt2' => 1
    },
    {
      'slot' => 'difficult2_achieve_what'
    },
    {
      'slot' => 'difficult2_achieve_how'
    },
    {
      'html' => 1,
      'text' => '<strong>AGREED ACTION</strong>'
    },
    {
      'rows' => [
        [
          {
            'slot' => 'difficult2_referral_1'
          },
          {
            'slot' => 'difficult2_referral_1_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult2_resource_1'
          },
          {
            'slot' => 'difficult2_resource_1_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult2_referral_2'
          },
          {
            'slot' => 'difficult2_referral_2_other_specify'
          }
        ],
        [
          {
            'slot' => 'difficult2_resource_2'
          },
          {
            'slot' => 'difficult2_resource_2_other_specify'
          }
        ]
      ],
      'widget' => 'multi_textbox_table'
    },
    {
      'slot' => 'difficult2_review_progress'
    }
  ],

};
}});
$pages{'PAGE_care_nav_action_3_last'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_action_3_last',
  'nav' => [
    {
      'next' => 'Complete Form'
    },
    {
      'prev' => 'Prev'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'prev' => 1,
    'show' => 1
  },
  'percent' => 40,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_action_2',
  'qns' => [
    {
      'heading' => 'Action plan'
    },
    {
      'slot' => 'making_work'
    },
    {
      'slot' => 'understanding_emotional'
    },
    {
      'slot' => 'completing_gp'
    },
    {
      'slot' => 'risk_assessment'
    },
    {
      'slot' => 'provisional_diagnosis'
    },
    {
      'slot' => 'chance_talk_yourself'
    },
    {
      'slot' => 'developed_action_plan'
    },
    {
      'slot' => 'offered_plan'
    },
    {
      'html' => 1,
      'text' => '<p><strong>CONGRATULATIONS, YOU HAVE COME UP WITH AN ACTION PLAN TO ACHIEVE YOUR GOALS AND IMPROVE YOUR WELLBEING</strong></p>
'
    }
  ],
  'next' => sub { $_[1]->set(considered_complete => time()); 'redirect_to_admin' },

};
}});
$pages{'last'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'last',
  'nav' => [
    {
      'first' => 'Start'
    },
    {
      'prev' => 'Prev'
    },
    {
      'next' => 'Submit'
    }
  ],
  'percent' => 99,
  'prev' => 'PAGE_care_nav_action_3_last',
  'qns' => [
    {
      'text' => '[% PROCESS last %]',
      'tt2' => 1
    }
  ],
  'next' => sub { $_[1]->set(completed=>time()); 'completed' },

};
}});
$pages{'redirect_to_admin'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'redirect_to_admin',
  'next' => 'last',
  'percent' => 80,
  'prev' => 'last',
  'template' => 'back-to-admin-site',

};
}});


my $lasts_prev_name = 'redirect_to_admin';

    # Fill in last and completed
$pages{last} = SD::Page->new({
      name => 'last',
      prev => $lasts_prev_name,
      percent => 100,
      qns => [ 'Review your answers then hit next to finish' ],
      next => sub { $_[1]->set(completed=>time()); 'completed' },
      slots => {},
      prev => $lasts_prev_name,
    }) unless exists $pages{last};

$pages{completed} = SD::Page->new({
      name => 'completed',
      first => 0, next => 0, prev => 0, # trapped
      template => 'completed',
      slots => {},
    }) unless exists $pages{completed};
# -- Initialize
# XXX playing inside page
for my $p (values %pages) {

    # Check and organize the page's "slots" hash
    if( exists $p->{slots} ) {
        if (ref $p->{slots} eq 'ARRAY') {
            # page is telling us which slots to save
            my %pslots;
            tie %pslots, 'Tie::IxHash' if $ENV{SD_CONTENT_ORDERED};
            %pslots = map { ( $_ => $slots{$_} ) } @{$p->{slots}};
            $p->{slots} = \%pslots;
        } elsif (ref $p->{slots} eq 'HASH') {
            # page has a defined slots hash, lets hope it's valid
            # XXX could check
        } else {
            die "Strange slots for $p->{name}: ",YAML::Dump($p->{slots});
        }
    } else {
        # Build a page's "slots" hash
        my @pslots;
        rmap_hash {
            # just find top-level slot names
            push @pslots, $_->{slot} and cut if($_->{slot});
        } $p->{qns};

        my %pslots;
        tie %pslots, 'Tie::IxHash' if $ENV{SD_CONTENT_ORDERED};
        %pslots = map { ( $_ => $slots{$_} ) } @pslots;
        $p->{slots} = \%pslots;
    }
}

# Link in slot objects (replace name with object)
rmap_hash {
    $_ = $slots{$_->{slot}} if $_->{slot};
} values %pages;

my @postprocessors = qw();
for my $postprocessor (@postprocessors) {
    eval "use $postprocessor; 1" or die "Couldn't load $postprocessor: $!";
    $postprocessor->process(\%pages, \%slots);
}

# -----DEBUG-----
#use Data::Dumper;
#$Data::Dumper::Purity = 1;
#print Data::Dumper->new(['%pages',\%pages])->Terse(1)->Indent(1)->Dump;
#print YAML::Dump \%pages;

no warnings 'void'; # keep next line quiet
\%pages; # returned value

# y2p 2017-10-25T17:03:11 1
