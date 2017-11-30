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
$slots{'written_communication_time_min'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'name' => 'written_communication_time_min',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59
  ],

};
}});
$slots{'written_communication_time_hr'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'name' => 'written_communication_time_hr',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
  ],

};
}});
$slots{'written_communication_format'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 20,
  'name' => 'written_communication_format',
  'rows' => 2,

};
}});
$slots{'written_communication_date'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'name' => 'written_communication_date',
  'picker' => 'none',

};
}});
$slots{'verbal_communication_time_min'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'name' => 'verbal_communication_time_min',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59
  ],

};
}});
$slots{'verbal_communication_time_hr'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'name' => 'verbal_communication_time_hr',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
  ],

};
}});
$slots{'verbal_communication_format'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 20,
  'name' => 'verbal_communication_format',
  'rows' => 2,

};
}});
$slots{'verbal_communication_date'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'name' => 'verbal_communication_date',
  'picker' => 'none',

};
}});
$slots{'typical_day'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What does a typical day involve for you?',
  'name' => 'typical_day',
  'rows' => 4,

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
$slots{'told_anyone_following'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Who have you told and what have you said to them?',
  'name' => 'told_anyone_following',
  'rows' => 4,

};
}});
$slots{'told_anyone'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'name' => 'told_anyone',

};
}});
$slots{'taking_medication'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'Are you currently taking any medication for your mental or physical health?',
  'mandatory' => 1,
  'name' => 'taking_medication',

};
}});
$slots{'surname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Surname'
  },
  'name' => 'surname',
  'size' => 60,
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
},

};
}});
$slots{'support_network'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'How do you feel about your support network? Are there people you can turn to when you need help?',
  'name' => 'support_network',
  'rows' => 4,

};
}});
$slots{'someone_talk'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Do you have someone else you can talk to if you feel like this again? A health professional or a family member or friend?',
  'name' => 'someone_talk',
  'rows' => 4,

};
}});
$slots{'simple_custom_value_select'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'name' => 'simple_custom_value_select',
  'widget' => 'simple_custom_value_select',
  'check' => sub {
  my ( $self, $item ) = @_;
  return 1 if ( $self->open );
  # $item must be a valid key to the option_keys hash
  my $keys = $self->option_keys;
  die E->new("Not one of the allowed responses") unless exists $keys->{$item};
  return 1;
},
  'option_keys' => sub {
  my $self = shift;
  # XXX: Use a preprocessor to pre-calculate and store this result
  my %options = map { $_ => 1 } @{ $self->options };
  return \%options;
},

};
}});
$slots{'see_professional_again'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Would you see a professional again? (Why/why not?)',
  'name' => 'see_professional_again',
  'rows' => 4,

};
}});
$slots{'received_professional_times'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'How many times did you see them? What did they do?',
  'name' => 'received_professional_times',
  'rows' => 4,

};
}});
$slots{'received_professional'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'Have you ever received professional help for your mental health?',
  'mandatory' => 1,
  'name' => 'received_professional',

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
$slots{'practice_name'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Practice name'
  },
  'name' => 'practice_name',
  'size' => 60,

};
}});
$slots{'practice_address'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'mail-address',
  'cols' => 60,
  'label' => {
    'position' => 'aligned',
    'text' => 'Practice address'
  },
  'name' => 'practice_address',
  'rows' => 3,

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
$slots{'practice_phone'} = $slots{phone_check}->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Practice phone'
  },
  'name' => 'practice_phone',

};
}});
$slots{'phone'} = $slots{phone_check}->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Phone'
  },
  'name' => 'phone',
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
},

};
}});
$slots{'past_month_harm_following'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What plans or methods have you considered? Is the method you would use readily available?',
  'name' => 'past_month_harm_following',
  'rows' => 4,

};
}});
$slots{'past_month_harm'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'name' => 'past_month_harm',

};
}});
$slots{'online_program_what'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What was it called?',
  'name' => 'online_program_what',
  'rows' => 4,

};
}});
$slots{'online_program_use'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'How long did you use it for?',
  'name' => 'online_program_use',
  'rows' => 4,

};
}});
$slots{'online_program_again'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Would you use something like this again? (Why/why not?)',
  'name' => 'online_program_again',
  'rows' => 4,

};
}});
$slots{'online_program'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'Have you ever used an online program or app for your mental health?',
  'mandatory' => 1,
  'name' => 'online_program',

};
}});
$slots{'new'} = SD::Slot::record->new(do {{
my $VAR1 = {
  'columns' => [
    {
      'slot' => 'appointment_date'
    },
    {
      'slot' => 'appointment_time_hr'
    },
    {
      'slot' => 'appointment_time_min'
    },
    {
      'slot' => 'appointment_cn'
    }
  ],
  'label' => {
    'text' => '[% loop.count %]',
    'tt2' => 1
  },
  'name' => 'new',
  'headings' => sub { my $self = shift; map { $_->label || undef } @{$self->columns} },

};
}});
$slots{'navigator_comments'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => {
    'html' => 1,
    'text' => '<p>Navigator: record additional comments here<br/>
<em>Consider risk and protective factors: history of suicidal behaviour, medical conditions, insight, mental state, recent major life events, support network, links with health services, substance abuse</em>
</p>
'
  },
  'name' => 'navigator_comments',
  'rows' => 4,

};
}});
$slots{'name_satisfied_medication'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Do you know the name? Are you satisfied with your medications?',
  'name' => 'name_satisfied_medication',
  'rows' => 4,

};
}});
$slots{'mental_group_what'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What was the group?',
  'name' => 'mental_group_what',
  'rows' => 4,

};
}});
$slots{'mental_group_times'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => 'How many times did you go?',
  'name' => 'mental_group_times',

};
}});
$slots{'mental_group_happened'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What happened during the sessions?',
  'name' => 'mental_group_happened',
  'rows' => 4,

};
}});
$slots{'mental_group_again'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Would you do something like this again? (Why/why not?)',
  'name' => 'mental_group_again',
  'rows' => 4,

};
}});
$slots{'mental_group'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'Have you ever participated in a mental health treatment group?',
  'mandatory' => 1,
  'name' => 'mental_group',

};
}});
$slots{'medical_conditions'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Do you have any medical conditions I should know about?',
  'name' => 'medical_conditions',
  'rows' => 4,

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
$slots{'received_professional_who'} = $slots{mc_v}->new(do {{
my $VAR1 = {
  'label' => 'Who did you see?',
  'name' => 'received_professional_who',
  'open' => [
    6
  ],
  'options' => [
    'Psychiatrist',
    'Psychologist',
    'Social worker',
    'Nurse',
    'Not sure',
    'Other',
    {
      'label' => 'Please specify',
      'size' => 100,
      'type' => 'text'
    }
  ],

};
}});
$slots{'mc_h'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_h',
  'widget' => 'choice_h',

};
}});
$slots{'living_situation'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What is your living situation like?',
  'name' => 'living_situation',
  'rows' => 4,

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
$slots{'interested_professional'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Is this something you would be interested in? (Why/why not?)',
  'name' => 'interested_professional',
  'rows' => 4,

};
}});
$slots{'interested_online_program'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Is this something you would be interested in? (Why/why not?)',
  'name' => 'interested_online_program',
  'rows' => 4,

};
}});
$slots{'interested_mental_group'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Is this something you would be interested in? (Why/why not?)',
  'name' => 'interested_mental_group',
  'rows' => 4,

};
}});
$slots{'interested_medication'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Is this something you would be interested in? (Why/why not?)',
  'name' => 'interested_medication',
  'rows' => 4,

};
}});
$slots{'important_know'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Is there anything else that\'s important for me to know?',
  'name' => 'important_know',
  'rows' => 4,

};
}});
$slots{'hobbies_interets'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What are your hobbies or interests? Are you involved in any community groups, charities, etc?',
  'name' => 'hobbies_interets',
  'rows' => 4,

};
}});
$slots{'gp_name'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'GP name'
  },
  'name' => 'gp_name',
  'size' => 60,

};
}});
$slots{'firstname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'First name'
  },
  'name' => 'firstname',
  'size' => 60,
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
},

};
}});
$slots{'feeling_suicidal'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'Are you currently feeling that way?',
  'mandatory' => 1,
  'name' => 'feeling_suicidal',

};
}});
$slots{'ever_attempted_harm_following'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'When was this? What happened?',
  'name' => 'ever_attempted_harm_following',
  'rows' => 4,

};
}});
$slots{'ever_attempted_harm'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'name' => 'ever_attempted_harm',

};
}});
$slots{'emergency_contact_phone'} = $slots{phone_check}->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Emergency contact phone'
  },
  'name' => 'emergency_contact_phone',

};
}});
$slots{'emergency_contact_name'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Emergency contact name'
  },
  'name' => 'emergency_contact_name',
  'size' => 60,

};
}});
$slots{'email_sent'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Do you still have the email we sent you, with the list of helplines and websites?',
  'name' => 'email_sent',
  'rows' => 4,

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
$slots{'email'} = $slots{email_check}->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Email'
  },
  'name' => 'email',
  'size' => 60,
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
},

};
}});
$slots{'dob'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'class' => 'dobfield',
  'label' => {
    'position' => 'aligned',
    'text' => 'Date of birth'
  },
  'name' => 'dob',
  'picker' => 'none',
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
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
$slots{'consider_services'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'If you did feel [suicidal] again, would you consider using any of the services on there?',
  'name' => 'consider_services',
  'rows' => 4,

};
}});
$slots{'comfortable_raising_gp'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'If you did feel that way [suicidal] again, would you feel comfortable raising this with your GP?',
  'name' => 'comfortable_raising_gp',
  'rows' => 4,

};
}});
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'c_h'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_h',
  'widget' => 'choice_h',

};
}});
$slots{'appointment_time_min'} = $slots{simple_custom_value_select}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => '<br/>(MM)'
  },
  'name' => 'appointment_time_min',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59
  ],

};
}});
$slots{'appointment_time_hr'} = $slots{simple_custom_value_select}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Time<br/>(HH)'
  },
  'name' => 'appointment_time_hr',
  'options' => [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
  ],

};
}});
$slots{'appointment_date'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'label' => 'Date',
  'name' => 'appointment_date',
  'picker' => 'none',

};
}});
$slots{'appointment_cn'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => 'Care Navigator',
  'name' => 'appointment_cn',
  'size' => 40,

};
}});
$slots{'appointment'} = SD::Slot::multi->new(do {{
my $VAR1 = {
  'button' => 'Appointment',
  'class' => 'shift-log add-appointment',
  'element' => {
    'slot' => 'new'
  },
  'extendable' => 1,
  'name' => 'appointment',
  'start_rows' => 1,
  'widget' => 'multi_list',

};
}});
$slots{'any_risk_hurt_following'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What do you think you might do?',
  'name' => 'any_risk_hurt_following',
  'rows' => 4,

};
}});
$slots{'any_risk_hurt'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'name' => 'any_risk_hurt',

};
}});
$slots{'address'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'mail-address',
  'cols' => 60,
  'label' => {
    'position' => 'aligned',
    'text' => 'Address'
  },
  'name' => 'address',
  'rows' => 3,
  'default' => sub {
    my ($slot, $session) = @_;
    my $conf = SD::Config->load;
    my $survey_session = $conf->{fetch_session}->($session->get('survey_session_key'), 'survey');
    return $survey_session ? $survey_session->get($slot->name) : "";
},

};
}});
$slots{'additional_comments'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 60,
  'label' => 'Additional comments',
  'name' => 'additional_comments',
  'rows' => 2,

};
}});
$slots{'actually_attempt_hurt_following'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Can you be specific about how you might do this? Is the method you would use readily available?',
  'name' => 'actually_attempt_hurt_following',
  'rows' => 4,

};
}});
$slots{'actually_attempt_hurt'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'name' => 'actually_attempt_hurt',

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
  'next' => 'PAGE_risk_assessment_1',
  'percent' => 0,
  'portal' => 'redirect_to_admin',
  'prev' => 0,
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'text' => '[% survey_session = conf.fetch_session(session.get(\'survey_session_key\'), \'survey\') %]
<div class="infobox">
  Patient name: [% session.get(\'firstname\') || survey_session.get(\'firstname\') %] [% session.get(\'surname\') || survey_session.get(\'surname\') %]<br/>
  Phone: [% session.get(\'phone\') || survey_session.get(\'phone\') %]<br/>
  Email: [% session.get(\'email\') || survey_session.get(\'email\') %]<br/>
  Address: [% session.get(\'address\') || survey_session.get(\'address\') %]<br/>
  GP name: [% session.get(\'gp\') || \'N/A\' %]<br/>
</div>
<p>You indicated in the Link-me iPad survey that you have been bothered by thoughts that you would be better off dead or of hurting yourself in some way.</p>
',
      'tt2' => 1
    },
    {
      'slot' => 'feeling_suicidal'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_risk_assessment_2',
      'default' => 'PAGE_risk_assessment_1'
    },
    'var' => 'feeling_suicidal'
  },

};
}});
$pages{'start'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_risk_assessment_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_risk_assessment_1',
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
  'next' => 'PAGE_risk_assessment_5',
  'percent' => 4,
  'portal' => 'redirect_to_admin',
  'prev' => 'start',
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'slot' => 'comfortable_raising_gp'
    },
    {
      'slot' => 'someone_talk'
    },
    {
      'slot' => 'email_sent'
    },
    {
      'slot' => 'consider_services'
    }
  ],

};
}});
$pages{'PAGE_risk_assessment_2'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_risk_assessment_2',
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
  'percent' => 8,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_risk_assessment_1',
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'past_month_harm_following'
        }
      ],
      'label' => 'In the past month, have you made any plans or considered a method that you might use to harm yourself?',
      'qn' => {
        'slot' => 'past_month_harm'
      },
      'widget' => 'following_questions'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'ever_attempted_harm_following'
        }
      ],
      'label' => 'Have you ever attempted to harm yourself?',
      'qn' => {
        'slot' => 'ever_attempted_harm'
      },
      'widget' => 'following_questions'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'actually_attempt_hurt_following'
        }
      ],
      'label' => 'There\'s a big difference between having a thought and acting on it. Do you think you might actually make an attempt to hurt yourself in the near future?',
      'qn' => {
        'slot' => 'actually_attempt_hurt'
      },
      'widget' => 'following_questions'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'told_anyone_following'
        }
      ],
      'label' => 'In the past month, have you told anyone that you were going to commit suicide, or threatened that you might do it?',
      'qn' => {
        'slot' => 'told_anyone'
      },
      'widget' => 'following_questions'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'any_risk_hurt_following'
        }
      ],
      'label' => 'Do you think there is any risk that you might hurt yourself before you see your doctor or counsellor the next time?',
      'qn' => {
        'slot' => 'any_risk_hurt'
      },
      'widget' => 'following_questions'
    },
    {
      'slot' => 'navigator_comments'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  my $attempt = $session->get('actually_attempt_hurt');
   my $risk = $session->get('any_risk_hurt');

  if ( $attempt == 1 || $risk == 1 ) {
     return 'PAGE_risk_assessment_3';
  } else {
     return 'PAGE_risk_assessment_5';
  }
},

};
}});
$pages{'PAGE_risk_assessment_3'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_risk_assessment_3',
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
  'next' => 'PAGE_risk_assessment_4',
  'percent' => 12,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_risk_assessment_2',
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'html' => 1,
      'text' => '<p>It sounds like things are pretty difficult for you at the moment. I need to let your GP know what we\'ve talked about today, and I\'d suggest that you make an appointment to see him/her.</p>
<p>Can I also remind you about the list of other services we emailed to you. They all provide free and confidential support so if your GP isn\'t available or you don\'t feel comfortable talking to him/her, you might like to call one of the numbers on that list.</p>
'
    }
  ],

};
}});
$pages{'PAGE_risk_assessment_4'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_risk_assessment_4',
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
  'percent' => 16,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_risk_assessment_3',
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'html' => 1,
      'text' => "<p><strong>Care navigator: Alert practice to your risk assessment with this patient <u>both</u> verbally and in writing (copy and paste the template below).</strong></p>
<div class=\"infobox consent\">
  <p>Dear Dr [name]</p>
  <p>RE: Patient name, DOB</p>
  <p>[Patient] is taking part in the Link-me trial. Based on his/her answers to our survey I contacted him/her today for a structured suicide risk assessment.</p>
  <p>In this assessment [patient] indicated that he/she has a plan and considers him/herself at risk of acting on it in the near future / before he/she next sees you.</p>
  <p>I am writing to inform you of [patient]\x{2019}s current difficulties and trust you will form your own impressions when you see him/her. If you would like to discuss this assessment in more detail please let me know.</p>
  <p>[Care Navigator name]</p>
</div>
"
    },
    {
      'html' => 1,
      'text' => '<h3>DETAILS OF RISK ASSESSMENT COMMUNICATION</h3>
<p>Written documentation</p>
'
    },
    {
      'headings' => [
        'Date',
        'Time (HHMM)',
        undef,
        'Format'
      ],
      'html' => 1,
      'rows' => [
        [
          {
            'slot' => 'written_communication_date'
          },
          {
            'slot' => 'written_communication_time_hr'
          },
          {
            'slot' => 'written_communication_time_min'
          },
          {
            'slot' => 'written_communication_format'
          }
        ]
      ],
      'widget' => 'multi_textbox_table'
    },
    {
      'html' => 1,
      'text' => '<p>Verbal communication  </p>
'
    },
    {
      'headings' => [
        'Date',
        'Time (HHMM)',
        undef,
        'Spoke to'
      ],
      'html' => 1,
      'rows' => [
        [
          {
            'slot' => 'verbal_communication_date'
          },
          {
            'slot' => 'verbal_communication_time_hr'
          },
          {
            'slot' => 'verbal_communication_time_min'
          },
          {
            'slot' => 'verbal_communication_format'
          }
        ]
      ],
      'widget' => 'multi_textbox_table'
    },
    {
      'slot' => 'additional_comments'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  $session->set(risk_assessment_complete => time());
  return 'redirect_to_admin';
},

};
}});
$pages{'PAGE_risk_assessment_5'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_risk_assessment_5',
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
  'percent' => 20,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_risk_assessment_4',
  'qns' => [
    {
      'heading' => 'Risk Assessment'
    },
    {
      'html' => 1,
      'text' => '<p>It sounds like you\'ve had some tough times but it\'s great to hear you\'re managing ok at the moment. If you feel like you need extra support your GP is here to help. You also have an email from us with some other services that provide free and confidential support.</p>
<p><strong>Care navigator: No further action required.</strong></p>
'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  $session->set(risk_assessment_complete => time());
  return 'redirect_to_admin';
},

};
}});
$pages{'PAGE_care_nav_rego_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_rego_1',
  'nav' => [
    {
      'next' => 'Complete Form'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'show' => 1
  },
  'next' => 'redirect_to_admin',
  'percent' => 25,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_risk_assessment_5',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Registration</h2>'
    },
    {
      'slot' => 'firstname'
    },
    {
      'slot' => 'surname'
    },
    {
      'slot' => 'dob'
    },
    {
      'slot' => 'phone'
    },
    {
      'slot' => 'address'
    },
    {
      'slot' => 'email'
    },
    {
      'slot' => 'emergency_contact_name'
    },
    {
      'slot' => 'emergency_contact_phone'
    },
    {
      'slot' => 'gp_name'
    },
    {
      'slot' => 'practice_name'
    },
    {
      'slot' => 'practice_address'
    },
    {
      'slot' => 'practice_phone'
    }
  ],

};
}});
$pages{'PAGE_care_nav_about_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_about_1',
  'nav' => [
    {
      'next' => 'Complete Form'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'show' => 1
  },
  'next' => 'redirect_to_admin',
  'percent' => 29,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_rego_1',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>About</h2>'
    },
    {
      'slot' => 'medical_conditions'
    },
    {
      'slot' => 'living_situation'
    },
    {
      'slot' => 'typical_day'
    },
    {
      'slot' => 'support_network'
    },
    {
      'slot' => 'hobbies_interets'
    },
    {
      'slot' => 'important_know'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_1',
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
  'next' => 'PAGE_care_nav_treatment_2',
  'percent' => 33,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_about_1',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'html' => 1,
      'text' => '<p>So that I can help you get the care that\'s right for you, I\'d like to know how you feel about different kinds of mental health treatment.</p>
'
    },
    {
      'slot' => 'taking_medication'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_care_nav_treatment_2',
      'default' => 'PAGE_care_nav_treatment_3'
    },
    'var' => 'taking_medication'
  },

};
}});
$pages{'PAGE_care_nav_treatment_1'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_care_nav_treatment_2'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_2',
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
  'next' => 'PAGE_care_nav_treatment_4',
  'percent' => 37,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_1',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'name_satisfied_medication'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_3'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_3',
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
  'next' => 'PAGE_care_nav_treatment_4',
  'percent' => 41,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_2',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'interested_medication'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_4'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_4',
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
  'next' => 'PAGE_care_nav_treatment_5',
  'percent' => 45,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_3',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'received_professional'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_care_nav_treatment_5',
      'default' => 'PAGE_care_nav_treatment_6'
    },
    'var' => 'received_professional'
  },

};
}});
$pages{'PAGE_care_nav_treatment_4'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_care_nav_treatment_5'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_5',
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
  'next' => 'PAGE_care_nav_treatment_7',
  'percent' => 50,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_4',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'received_professional_who'
    },
    {
      'slot' => 'received_professional_times'
    },
    {
      'slot' => 'see_professional_again'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_6'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_6',
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
  'next' => 'PAGE_care_nav_treatment_7',
  'percent' => 54,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_5',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'interested_professional'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_7'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_7',
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
  'next' => 'PAGE_care_nav_treatment_8',
  'percent' => 58,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_6',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'mental_group'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_care_nav_treatment_8',
      'default' => 'PAGE_care_nav_treatment_9'
    },
    'var' => 'mental_group'
  },

};
}});
$pages{'PAGE_care_nav_treatment_7'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_care_nav_treatment_8'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_8',
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
  'next' => 'PAGE_care_nav_treatment_10',
  'percent' => 62,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_7',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'mental_group_what'
    },
    {
      'slot' => 'mental_group_times'
    },
    {
      'slot' => 'mental_group_happened'
    },
    {
      'slot' => 'mental_group_again'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_9'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_9',
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
  'next' => 'PAGE_care_nav_treatment_10',
  'percent' => 66,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_8',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'interested_mental_group'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_10'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_10',
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
  'next' => 'PAGE_care_nav_treatment_11',
  'percent' => 70,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_9',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'online_program'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_care_nav_treatment_11',
      'default' => 'PAGE_care_nav_treatment_12'
    },
    'var' => 'online_program'
  },

};
}});
$pages{'PAGE_care_nav_treatment_10'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_care_nav_treatment_11'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_11',
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
  'next' => 'redirect_to_admin',
  'percent' => 75,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_10',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'online_program_what'
    },
    {
      'slot' => 'online_program_use'
    },
    {
      'slot' => 'online_program_again'
    }
  ],

};
}});
$pages{'PAGE_care_nav_treatment_12'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_treatment_12',
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
  'next' => 'redirect_to_admin',
  'percent' => 79,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_11',
  'qns' => [
    {
      'heading' => 'Care Navigation'
    },
    {
      'html' => 1,
      'text' => '<h2>Treatment experience</h2>'
    },
    {
      'slot' => 'interested_online_program'
    }
  ],

};
}});
$pages{'PAGE_care_nav_ipad_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_care_nav_ipad_1',
  'nav' => [
    {
      'next' => 'Complete Form'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'show' => 1
  },
  'next' => 'redirect_to_admin',
  'percent' => 83,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_treatment_12',
  'qns' => [
    {
      'heading' => 'iPad feedback'
    },
    {
      'text' => '<p>Based on your answers to the Link-me iPad survey</p>
[% survey_session = conf.fetch_session(session.get(\'survey_session_key\'), \'survey\') %]
[% intervention_areas = conf.intervention_areas; %]
',
      'tt2' => 1
    },
    {
      'text' => '<p>Things seem OK for you in these areas:</p>
[% ok_areas = conf.get_ok_areas(survey_session) %]
[% IF ok_areas.size == 0 %]
  N/A
[% ELSE %]
  <ul>
  [% FOR area IN ok_areas %]
    <li>[% intervention_areas.$area.option_text %]</li>
  [% END %]
  </ul>
[% END %]
',
      'tt2' => 1
    },
    {
      'text' => '<p>Things seem difficult for you in these areas:</p>
[% difficult_areas = conf.get_difficult_areas(survey_session) %]
[% IF difficult_areas.size == 0 %]
  N/A
[% ELSE %]
  <ul>
  [% FOR area IN difficult_areas %]
    <li>[% intervention_areas.$area.option_text %]</li>
  [% END %]
  </ul>
[% END %]
',
      'tt2' => 1
    },
    {
      'text' => '[%
  selected_difficult_areas = survey_session.get(\'q2\');

  first_area  = intervention_areas.${ selected_difficult_areas.first }.sentence_text;
  second_area = intervention_areas.${ selected_difficult_areas.last }.sentence_text;
%]
[% IF selected_difficult_areas.size == 2 %]
  <p>You selected [% first_area %] and [% second_area %] as the areas you\'d like to focus on.</p>
[% ELSE %]
  <p>You selected [% first_area %] as the area you\'d like to focus on.</p>
[% END %]
',
      'tt2' => 1
    },
    {
      'text' => '<p>You rated the importance of improving things in these areas as [% survey_session.get(\'motivation\') %] out of 10.</p>
',
      'tt2' => 1
    },
    {
      'text' => '<p>You rated the confidence of improving things in these areas as [% survey_session.get(\'confidence\') %] out of 10.</p>
',
      'tt2' => 1
    }
  ],

};
}});
$pages{'PAGE_new_appointment_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_new_appointment_1',
  'nav' => [
    {
      'next' => 'Complete Form'
    },
    {
      'portal' => 'Back to Portal'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'portal' => 1,
    'show' => 1
  },
  'next' => 'redirect_to_admin',
  'percent' => 87,
  'portal' => 'redirect_to_admin',
  'prev' => 'PAGE_care_nav_ipad_1',
  'qns' => [
    {
      'heading' => 'New Appointment'
    },
    {
      'slot' => 'appointment'
    }
  ],

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
  'prev' => 'PAGE_new_appointment_1',
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
  'percent' => 95,
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

# y2p 2017-10-25T17:03:20 1
