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
$slots{'y_n_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'mandatory' => 1,
  'name' => 'y_n_v',
  'options' => [
    {
      '1' => 'Yes'
    },
    {
      '0' => 'No'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No' }, { 1 => 'Yes' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No', 1 => 'Yes' }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'y_n'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'name' => 'y_n',
  'options' => [
    {
      '1' => 'Yes'
    },
    {
      '0' => 'No'
    }
  ],
  'widget' => 'choice_h_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No' }, { 1 => 'Yes' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No', 1 => 'Yes' }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'trial_enrolled'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Are you currently taking part in Link-me?',
  'madantory' => 1,
  'name' => 'trial_enrolled',

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
$slots{'surname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Surname'
  },
  'mandatory' => 1,
  'name' => 'surname',
  'size' => 40,

};
}});
$slots{'screened_past'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Have you filled out this survey before?',
  'mandatory' => 1,
  'name' => 'screened_past',

};
}});
$slots{'scale_10_important'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'mandatory' => 1,
  'name' => 'scale_10_important',
  'options' => [
    '1 Not at all important',
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    '10 Totally important'
  ],
  'widget' => 'choice_h',

};
}});
$slots{'scale_10_confident'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'mandatory' => 1,
  'name' => 'scale_10_confident',
  'options' => [
    '1 Not at all confident',
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    '10 Totally confident'
  ],
  'widget' => 'choice_h',

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
$slots{'phq_scale'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'mandatory' => 1,
  'name' => 'phq_scale',
  'options' => [
    {
      '0' => 'Not at all'
    },
    {
      '1' => 'Several days'
    },
    {
      '2' => 'More than half the days'
    },
    {
      '3' => 'Nearly every day'
    }
  ],
  'widget' => 'choice_h_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'Not at all' }, { 1 => 'Several days' }, { 2 => 'More than half the days' }, { 3 => 'Nearly every day' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Not at all', 1 => 'Several days'', 2 => 'More than half the days', 3 => 'Nearly every day' }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'phq9'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by thoughts that you would be better off dead or of hurting yourself in some way?'
  },
  'name' => 'phq9',
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;

  return if $session->get('phqdep_total');

  my $qn_prefix = "phq";

  # Current question answer is default total
  my $total     = $val;
  for my $x ( 1 .. 8 ) {
    my $val = $session->get("${qn_prefix}${x}");
    $total += $val;
  }

  $session->set(phqdep_total => $total);
},
  'check' => sub {
  my $self = shift;

  $self->super(@_);
  $self->algorithm_vars(@_);

  return 1;
},

};
}});
$slots{'phq8'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by moving or speaking so slowly that other people could have noticed? Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual?'
  },
  'name' => 'phq8',

};
}});
$slots{'phq7'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by trouble concentrating on things, such as reading the newspaper or watching television?'
  },
  'name' => 'phq7',

};
}});
$slots{'phq6'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by feeling bad about yourself - or that you are a failure or have let yourself or your family down?'
  },
  'name' => 'phq6',

};
}});
$slots{'phq5'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by poor appetite or overeating?'
  },
  'name' => 'phq5',

};
}});
$slots{'phq4'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by feeling tired or having little energy?'
  },
  'name' => 'phq4',

};
}});
$slots{'phq3'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by trouble falling or staying asleep, or sleeping too much?'
  },
  'name' => 'phq3',

};
}});
$slots{'phq2'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last 2 weeks</em></u>, how often have you been bothered by feeling down, depressed or hopeless?'
  },
  'name' => 'phq2',

};
}});
$slots{'phq1'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last 2 weeks</em></u>, how often have you been bothered by little interest or pleasure in doing things?'
  },
  'name' => 'phq1',

};
}});
$slots{'phone_check'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'consent',
  'mandatory' => 1,
  'max_val' => 9999999999,
  'min_val' => 0,
  'name' => 'phone_check',
  'size' => 20,
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
$slots{'phone'} = $slots{phone_check}->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Mobile'
  },
  'mandatory' => 1,
  'name' => 'phone',
  'size' => 20,

};
}});
$slots{'motivation'} = $slots{scale_10_important}->new(do {{
my $VAR1 = {
  'class' => 'single-line',
  'label' => 'How important is it for you to make some changes in these areas, on a scale from 1 to 10?',
  'mandatory' => 1,
  'name' => 'motivation',

};
}});
$slots{'med'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Do you take any medication for your mental health?',
  'name' => 'med',

};
}});
$slots{'mc_v'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_v',
  'widget' => 'choice_v',

};
}});
$slots{'q2'} = $slots{mc_v}->new(do {{
my $VAR1 = {
  'difficult_areas' => 1,
  'label' => 'You can only select up to two areas of difficulty',
  'max_responses' => 2,
  'min_responses' => 1,
  'name' => 'q2',
  'options' => [
    {
      'interest' => 'Little interest'
    },
    {
      'mood' => 'Mood'
    },
    {
      'sleep' => 'Sleep'
    },
    {
      'energy' => 'Energy'
    },
    {
      'appetite' => 'Appetite'
    },
    {
      'image' => 'Self-image'
    },
    {
      'concentration' => 'Concentration'
    },
    {
      'movement' => 'Movement'
    },
    {
      'death' => 'Thought of death'
    },
    {
      'anxiety' => 'Anxiety'
    },
    {
      'health' => 'Health'
    },
    {
      'activities' => 'Daily activities'
    },
    {
      'economy' => 'Finances'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val, $session) = @_;
  my $total_selected  = @{$val};
  if ($total_selected < $self->min_responses ) {
   die E::Skip->new("Please select at least one area of difficulty");
   return 0;
  } elsif ($total_selected > $self->max_responses) {
    die E::Skip->new("You can only select up to two areas of difficulty");
    return 0;
  }
  # options is: [ { 0 => 'Male' }, { 1 => 'Female' }, { 2 => 'Other' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Male', 1 => 'Female', 2 => 'Other'}
  unless ($opts{$val}) { # assume "true" labels
  # die E->new("Not one of allowed responses");
  }

  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'mc_h'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_h',
  'widget' => 'choice_h',

};
}});
$slots{'live_alone'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Do you live alone?',
  'name' => 'live_alone',

};
}});
$slots{'language'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Which language do you mainly speak at home?',
  'mandatory' => 1,
  'name' => 'language',
  'options' => [
    {
      '0' => 'English'
    },
    {
      '1' => 'Other'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'English' }, { 1 => 'Other' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'English', 1 => 'Other'}
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'k13'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'In the <u><em>last four weeks</em></u>, how many times have you seen a doctor or any other health professional about these feelings?'
  },
  'mandatory' => 1,
  'name' => 'k13',
  'size' => 4,

};
}});
$slots{'k12'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'Aside from those days, in the <u><em>last four weeks</em></u>, how many days were you able to work, study, or manage your day to day activities, but had to <u>cut down</u> on what you did because of these feelings?'
  },
  'mandatory' => 1,
  'max_val' => 28,
  'name' => 'k12',
  'size' => 4,

};
}});
$slots{'k11'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'In the <u><em>last four weeks</em></u>, how many days were you <u>totally unable</u> to work, study, or manage your day to day activities because of these feelings?'
  },
  'mandatory' => 1,
  'max_val' => 28,
  'name' => 'k11',
  'size' => 4,

};
}});
$slots{'k10_scale'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'mandatory' => 1,
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
$slots{'k9'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel so sad that nothing could cheer you up?'
  },
  'name' => 'k9',

};
}});
$slots{'k8'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel that everything was an effort?'
  },
  'name' => 'k8',

};
}});
$slots{'k7'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel depressed?'
  },
  'name' => 'k7',

};
}});
$slots{'k6'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel so restless you could not sit still?'
  },
  'name' => 'k6',

};
}});
$slots{'k5'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel restless or fidgety?'
  },
  'name' => 'k5',

};
}});
$slots{'k4'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel hopeless?'
  },
  'name' => 'k4',

};
}});
$slots{'k3'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel so nervous that nothing could calm you down?'
  },
  'name' => 'k3',

};
}});
$slots{'k2'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel nervous?'
  },
  'name' => 'k2',

};
}});
$slots{'k14'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'In the <u><em>last four weeks</em></u>, how often have physical health problems been the main cause of these feelings?'
  },
  'name' => 'k14',

};
}});
$slots{'k10'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel worthless?'
  },
  'name' => 'k10',

};
}});
$slots{'k1'} = $slots{k10_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'During the <u><em>last 30 days</em></u>, about how often did you feel tired out for no good reason?'
  },
  'name' => 'k1',

};
}});
$slots{'interested'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd whitehighlight',
  'mandatory' => 1,
  'name' => 'interested',
  'options' => [
    {
      '1' => 'I\'d like to get started with Link-me'
    },
    {
      '0' => 'No thanks, I\'ll stop here'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => "No thanks, I'll stop here" }, { 1 => "I'd like to get started with Link-me" } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => "No thanks, I'll stop here", 1 => "I'd like to get started with Link-me" }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'healthrange'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'name' => 'healthrange',
  'widget' => 'range',

};
}});
$slots{'gp_other'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If other, please specify your doctor name:',
  'name' => 'gp_other',
  'size' => 60,
  'mandatory' => sub {
  my ($self, $value, $session) = @_;
  if ($session->get('gp') eq 'Other') {
    return 1;
  }
  return 0;
},

};
}});
$slots{'gp'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => 'Which doctor are you seeing today?',
  'mandatory' => 1,
  'name' => 'gp',
  'other_text' => 'Other',
  'widget' => 'gp_select',
  'check' => sub {
  my ($self, $item, $session) = @_;
  return 1 if ( $self->open );
  # $item must be a valid key to the option_keys hash
  my $config         = SD::Config->load;
  my $gps            = $config->{gps};

  my $phn      = $session->get('phn');
  my $practice = $session->get('practice');

  my $gp_list = $gps ? $gps->{$phn}{$practice} : undef;

  my @options = (
    $self->other_text,
    "I'm not sure",
  );

  my %keys = map { $_ => 1 } (@options, @$gp_list);

  die E->new("Not one of the allowed responses") unless exists $keys{$item};

  return 1;
},

};
}});
$slots{'gender'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'What is your gender?',
  'mandatory' => 1,
  'name' => 'gender',
  'options' => [
    {
      '0' => 'Male'
    },
    {
      '1' => 'Female'
    },
    {
      '2' => 'Other'
    }
  ],
  'widget' => 'choice_v_altvals',
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;
  return if $session->get('gender_collapsed');

  # Collapse “other” and “female” into one group for the algorithm
  my $collapsed_val = $val >= 1 ? 1 : 0;
  $session->set(gender_collapsed => $collapsed_val);
},
  'check' => sub {
  my ($self, $val, $session) = @_;
  # options is: [ { 0 => 'Male' }, { 1 => 'Female' }, { 2 => 'Other' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Male', 1 => 'Female', 2 => 'Other'}
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }

  $self->algorithm_vars($val, $session);

  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'gad7'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by feeling afraid as if something awful might happen?'
  },
  'name' => 'gad7',
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;

  return if $session->get('gad_max');

  my $qn_prefix = "gad";
  # This slots value is total default
  my $total     = $val;
  for my $x ( 1 .. 6 ) {
    my $val = $session->get("${qn_prefix}${x}");
    $total += $val;
  }

  $session->set(gad_total => $total);

  my $gad1 = $session->get('gad1');
  my $gad2 = $session->get('gad2');

  my $gad1r = $gad1 >= 2 ? 2 : $gad1;
  my $gad2r = $gad2 >= 2 ? 2 : $gad2;

  $session->set(gad1r => $gad1r);
  $session->set(gad2r => $gad2r);

  my $gad_max = $gad1r > $gad2r ? $gad1r : $gad2r;
  $session->set(gad_max => $gad_max);
},
  'check' => sub {
  my $self = shift;

  $self->super(@_);
  $self->algorithm_vars(@_);

  return 1;
},

};
}});
$slots{'gad6'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by becoming easily annoyed or irritable?'
  },
  'name' => 'gad6',

};
}});
$slots{'gad5'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by being so restless that it is hard to sit still?'
  },
  'name' => 'gad5',

};
}});
$slots{'gad4'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by trouble relaxing?'
  },
  'name' => 'gad4',

};
}});
$slots{'gad3'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last two weeks</em></u>, how often have you been bothered by worrying too much about different things?'
  },
  'name' => 'gad3',

};
}});
$slots{'gad2'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last 2 weeks</em></u>, how often have you been bothered by not being able to stop or control worrying?'
  },
  'name' => 'gad2',

};
}});
$slots{'gad1'} = $slots{phq_scale}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Over the <u><em>last 2 weeks</em></u>, how often have you been bothered by feeling nervous, anxious, or on edge?'
  },
  'name' => 'gad1',

};
}});
$slots{'firstname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'First name'
  },
  'mandatory' => 1,
  'name' => 'firstname',
  'size' => 40,

};
}});
$slots{'ever_nointerest'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Have you <u>ever</u> been bothered by little interest or pleasure in doing things for longer than 2 weeks?'
  },
  'name' => 'ever_nointerest',
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;

  return if $session->get('ever_depressed');

  if ($val && $session->get('ever_down')) {
    $session->set(ever_depressed => 1);
  } else {
    $session->set(ever_depressed => 0);
  }
},
  'check' => sub {
  my $self = shift;

  $self->super(@_);
  $self->algorithm_vars(@_);

  return 1;
},

};
}});
$slots{'ever_down'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Have you <u>ever</u> been bothered by feeling down, depressed or hopeless for longer than 2 weeks?'
  },
  'name' => 'ever_down',

};
}});
$slots{'entry'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'mandatory' => 1,
  'name' => 'entry',
  'options' => [
    {
      '1' => 'Start'
    },
    {
      '0' => 'No thanks'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No thanks' }, { 1 => 'Start' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No thanks', 1 => 'Start' }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'employment'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'In terms of employment, in a usual week are you:',
  'mandatory' => 1,
  'name' => 'employment',
  'options' => [
    {
      '0' => 'Working for an employer for wages or salary'
    },
    {
      '1' => 'Working in your own business for profit or pay'
    },
    {
      '2' => 'Working without pay in a family business or on a farm'
    },
    {
      '3' => 'Unemployed, looking for and available to start work'
    },
    {
      '4' => 'None of the above'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'Working for an employer for wages or salary' }, { 1 => 'Working in your own business for profit or pay' }, { 2 => 'Working without pay in a family business or on a farm' }, { 3 => 'Unemployed, looking for and available to start work' }, { 4 => 'None of the above' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Working for an employer for wages or salary', 1 => 'Working in your own business for profit or pay', 2 => 'Working without pay in a family business or on a farm', 3 => 'Unemployed, looking for and available to start work', 4 => 'None of the above'}
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'email_check'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'input_type' => 'email',
  'mandatory' => 1,
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
  'mandatory' => 1,
  'name' => 'email',
  'size' => 40,

};
}});
$slots{'edu'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'What is the highest level of education you have completed?',
  'mandatory' => 1,
  'name' => 'edu',
  'options' => [
    {
      '0' => 'Below Year 10'
    },
    {
      '1' => 'Year 10'
    },
    {
      '2' => 'Year 11'
    },
    {
      '3' => 'Year 12 or equivalent'
    },
    {
      '4' => 'Certificate III/IV'
    },
    {
      '5' => 'Advanced Diploma / Diploma'
    },
    {
      '6' => 'Bachelor Degree'
    },
    {
      '7' => 'Graduate Diploma / Graduate Certificate'
    },
    {
      '8' => 'Postgraduate Degree'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'Below Year 10' }, { 1 => 'Year 10' }, { 2 => 'Year 11' }, { 3 => 'Year 12 or equivalent' }, { 4 => 'Certificate III/IV' }, { 5 => 'Advanced Diploma / Diploma' }, { 6 => 'Bachelor Degree' }, { 7 => 'Graduate Diploma / Graduate Certificate' }, { 8 => 'Postgraduate Degree' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Below Year 10', 1 => 'Year 10', 2 => 'Year 11', 3 => 'Year 12 or equivalent', 4 => 'Certificate III/IV', 5 => 'Advanced Diploma / Diploma', 6 => 'Bachelor Degree', 7 => 'Graduate Diploma / Graduate Certificate', 8 => 'Postgraduate Degree'}
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
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
  'mandatory' => 1,
  'name' => 'dob',
  'picker' => 'none',

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
$slots{'confidence'} = $slots{scale_10_confident}->new(do {{
my $VAR1 = {
  'class' => 'single-line',
  'label' => 'How confident are you about making changes in these areas, on a scale from 1 to 10?',
  'mandatory' => 1,
  'name' => 'confidence',

};
}});
$slots{'chronic'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Do you have any long-term illness or health problem, which limits your daily activities or the work you can do (including problems that are due to old age)?',
  'name' => 'chronic',

};
}});
$slots{'card'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => 'Do you currently hold an Australian Government Health Care Card or Pensioner Concession Card?',
  'mandatory' => 1,
  'name' => 'card',

};
}});
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'sf1_health'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'In general, would you say your health is:',
  'mandatory' => 1,
  'name' => 'sf1_health',
  'options' => [
    'Excellent',
    'Very good',
    'Good',
    'Fair',
    'Poor'
  ],
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;

  return if $session->get('sf1_health_collapse');

  my $collapsed_val = $val;

  if ($val <= 3) {
    $collapsed_val = 0;
  }

  $session->set(sf1_health_collapse => $collapsed_val);
},
  'check' => sub {
  my $self = shift;

  $self->super(@_);
  $self->algorithm_vars(@_);

  return 1;
},

};
}});
$slots{'inc_mg'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'How do you manage on your available income?',
  'mandatory' => 1,
  'name' => 'inc_mg',
  'options' => [
    'Easily',
    'Not too bad',
    'Difficult some of the time',
    'Difficult all of the time',
    'Impossible'
  ],
  'algorithm_vars' => sub {
  my ($self, $val, $session) = @_;

  return if $session->get('inc_mg_collapse');

  my $collapsed_val;

  if ($val <= 3) {
    $collapsed_val = 0;
  } elsif ($val > 3) {
    $collapsed_val = 1;
  }

  $session->set(inc_mg_collapse => $collapsed_val);
},
  'check' => sub {
  my $self = shift;

  $self->super(@_);
  $self->algorithm_vars(@_);

  return 1;
},

};
}});
$slots{'gp_reason'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'Is your visit to the doctor today mainly related to your:',
  'mandatory' => 1,
  'name' => 'gp_reason',
  'options' => [
    'Physical health',
    'Mental health and wellbeing',
    'Both physical and mental health',
    'None of these'
  ],

};
}});
$slots{'eq_vas'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => '<p>We would like to know how good or bad your health is <u><em>today</em></u>.<br/>
  This scale is numbered from 0 to 100.<br/>
  100 means the <u><em>best</em></u> health you can imagine<br/>
  0 means the <u><em>worst</em></u> health you can imagine.<br/>
  Please click on the scale to indicate how your health is <u><em>today</em></u>.</p>
  <h1 id="range-value"></h1>
'
  },
  'name' => 'eq_vas',

};
}});
$slots{'eq5'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'ANXIETY / DEPRESSION',
  'name' => 'eq5',
  'options' => [
    'I am not anxious or depressed',
    'I am slightly anxious or depressed',
    'I am moderately anxious or depressed',
    'I am severely anxious or depressed',
    'I am extremely anxious or depressed'
  ],

};
}});
$slots{'eq4'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'PAIN / DISCOMFORT',
  'name' => 'eq4',
  'options' => [
    'I have no pain or discomfort',
    'I have slight pain or discomfort',
    'I have moderate pain or discomfort',
    'I have severe pain or discomfort',
    'I have extreme pain or discomfort'
  ],

};
}});
$slots{'eq3'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'USUAL ACTIVITIES (e.g., work, study, housework, family, or leisure activities)',
  'name' => 'eq3',
  'options' => [
    'I have no problems doing my usual activities',
    'I have slight problems doing my usual activities',
    'I have moderate problems doing my usual activities',
    'I have severe problems doing my usual activities',
    'I am unable to do my usual activities'
  ],

};
}});
$slots{'eq2'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'SELF-CARE',
  'name' => 'eq2',
  'options' => [
    'I have no problems washing or dressing myself',
    'I have slight problems washing or dressing myself',
    'I have moderate problems washing or dressing myself',
    'I have severe problems washing or dressing myself',
    'I am unable to wash or dress myself'
  ],

};
}});
$slots{'eq1'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'MOBILITY',
  'name' => 'eq1',
  'options' => [
    'I have no problems in walking about',
    'I have slight problems in walking about',
    'I have moderate problems in walking about',
    'I have severe problems in walking about',
    'I am unable to walk about'
  ],

};
}});
$slots{'custom_value'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'custom_value',
  'widget' => 'custom_value_select',
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
  my $ctr = 0;
  return { map { $_->[0] => $ctr++ } @{ $self->options } }
},
  'pretty_value' => sub {
  my ( $self, $val ) = @_;
  my $keys = $self->option_keys;
  return $self->options->[ $keys->{$val} ]->[1];
},

};
}});
$slots{'c_h'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_h',
  'widget' => 'choice_h',

};
}});
$slots{'atsi'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Are you of Aboriginal or Torres Strait Islander origin?',
  'mandatory' => 1,
  'name' => 'atsi',
  'options' => [
    {
      '0' => 'No'
    },
    {
      '1' => 'Yes, Aboriginal only'
    },
    {
      '2' => 'Yes, Torres Strait Islander only'
    },
    {
      '3' => 'Yes, both Aboriginal and Torres Strait Islander'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No' }, { 1 => 'Yes, Aboriginal only' }, { 2 => 'Yes, Torres Strait Islander only' }, { 3 => 'Yes, both Aboriginal and Torres Strait Islander' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No', 1 => 'Yes, Aboriginal only', 2 => 'Yes, Torres Strait Islander', 3 => 'Yes, both Aboriginal and Torres Strait Islander'}
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});
$slots{'age'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => 'What is your age (in years)?',
  'mandatory' => 1,
  'name' => 'age',
  'size' => 3,

};
}});
$slots{'address'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'mail-address',
  'cols' => 40,
  'label' => {
    'position' => 'aligned',
    'text' => 'Mail address'
  },
  'name' => 'address',
  'rows' => 3,

};
}});
$slots{'activities'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => {
    'html' => 1,
    'text' => 'In a usual week, which of the following best describes your <u>main</u> activity?'
  },
  'mandatory' => 1,
  'name' => 'activities',
  'options' => [
    {
      '0' => 'Retired or voluntarily inactive'
    },
    {
      '1' => 'Home duties'
    },
    {
      '2' => 'Caring for children'
    },
    {
      '3' => 'Studying'
    },
    {
      '4' => 'Unable to work due to own illness, injury, or disability'
    },
    {
      '5' => 'Caring for an ill or disabled person'
    },
    {
      '6' => 'Working in an unpaid voluntary job'
    },
    {
      '7' => 'Other'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'Retired or voluntarily inactive' }, { 1 => 'Home duties' }, { 2 => 'Caring for children ' }, { 3 => 'Studying' }, { 4 => 'Unable to work due to own illness, injury, or disability' }, { 5 => 'Caring for an ill or disabled person' }, { 6 => 'Working in an unpaid voluntary job' }, { 7 => 'Other' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'Retired or voluntarily inactive', 1 => 'Home duties', 2 => 'Caring for children ', 3 => 'Studying', 4 => 'Unable to work due to own illness, injury, or disability', 5 => 'Caring for an ill or disabled person', 6 => 'Working in an unpaid voluntary job', 7 => 'Other' }
  unless ($opts{$val}) { # assume "true" labels
      die E->new("Not one of allowed responses");
  }
  return 1;
},
  'perdy_value' => sub {
  my ($self, $val) = @_;
  return "" if ! defined $val; # empty string if not defined
  my %opts = map { %$_ } @{ $self->options };
  return $opts{$val} || $val;
},

};
}});



# -----PAGES----- $page_code output:
$pages{'start'} = SD::Page->new(do {{
my $VAR1 = {
  'first' => 0,
  'name' => 'start',
  'nav' => [
    {
      'parent' => 'Clinic use only'
    },
    {
      'next' => 'Next'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'parent' => 1,
    'show' => 1
  },
  'parent' => 'redirect_to_create_new_session',
  'percent' => 0,
  'prev' => 0,
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Our practice is committed to helping you look after your mental health and wellbeing. That\'s why we are taking part in Link-me: a national trial of a new approach to mental health care.</p>
<p class="splashpage-highlight">We invite you to take a 2 minute survey to see if Link-me is right for you.</p>
'
    },
    {
      'slot' => 'entry'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  if ($session->get('entry') == 1) {
    return 'PAGE_001';
  }

  if (!$session->get('out_of_study')) {
    $session->set(out_of_study => time());
  }

  return 'PAGE_last_A';
},

};
}});
$pages{'PAGE_001'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_001',
  'nav' => [
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'nav_actions' => {
    'next' => 1,
    'prev' => 1,
    'show' => 1
  },
  'next' => 'PAGE_002',
  'parent' => 'redirect_to_default',
  'percent' => 1,
  'prev' => 'start',
  'qns' => [
    {
      'slot' => 'screened_past'
    }
  ],
  'switch' => {
    'cases' => {
      '1' => 'PAGE_002',
      'default' => 'PAGE_003'
    },
    'var' => 'screened_past'
  },

};
}});
$pages{'PAGE_001'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_002'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_002',
  'percent' => 3,
  'prev' => 'PAGE_001',
  'qns' => [
    {
      'slot' => 'trial_enrolled'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  if ($session->get('trial_enrolled') == 1) {
     if (!$session->get('ineligible')) {
      $session->set(ineligible => time());
      $session->set(out_of_study => time());
      $session->set(eligible => undef);
     }

     return 'PAGE_last_A';
  } else {
     return 'PAGE_003';
  }
},

};
}});
$pages{'PAGE_003'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_003',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'percent' => 5,
  'prev' => 'PAGE_002',
  'qns' => [
    {
      'slot' => 'age'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  my $age = $session->get('age');

  if ( $age < 18 || $age > 75 ) {
     if (!$session->get('ineligible')) {
      $session->set(ineligible => time());
      $session->set(out_of_study => time());
      $session->set(eligible => undef);
     }
     return 'PAGE_last_A';
  } else {
     return 'PAGE_004';
  }
},

};
}});
$pages{'PAGE_004'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_004',
  'next' => 'PAGE_004B',
  'percent' => 7,
  'prev' => 'PAGE_003',
  'qns' => [
    {
      'slot' => 'gender'
    }
  ],

};
}});
$pages{'PAGE_004B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_004B',
  'next' => 'PAGE_005',
  'percent' => 9,
  'prev' => 'PAGE_004',
  'qns' => [
    {
      'slot' => 'atsi'
    },
    {
      'slot' => 'language'
    }
  ],

};
}});
$pages{'PAGE_005'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_005',
  'next' => 'PAGE_005B',
  'percent' => 11,
  'prev' => 'PAGE_004B',
  'qns' => [
    {
      'slot' => 'edu'
    }
  ],

};
}});
$pages{'PAGE_005B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_005B',
  'next' => 'PAGE_005C',
  'percent' => 13,
  'prev' => 'PAGE_005',
  'qns' => [
    {
      'slot' => 'employment'
    }
  ],
  'switch' => {
    'cases' => {
      '4' => 'PAGE_005C',
      'default' => 'PAGE_005D'
    },
    'var' => 'employment'
  },

};
}});
$pages{'PAGE_005B'}{next} = \&WS::Page::Switch::switch;
$pages{'PAGE_005C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_005C',
  'next' => 'PAGE_005D',
  'percent' => 15,
  'prev' => 'PAGE_005B',
  'qns' => [
    {
      'slot' => 'activities'
    }
  ],

};
}});
$pages{'PAGE_005D'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_005D',
  'next' => 'PAGE_006',
  'percent' => 17,
  'prev' => 'PAGE_005C',
  'qns' => [
    {
      'slot' => 'card'
    }
  ],

};
}});
$pages{'PAGE_006'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_006',
  'next' => 'PAGE_006B',
  'percent' => 19,
  'prev' => 'PAGE_005D',
  'qns' => [
    {
      'slot' => 'phq1'
    },
    {
      'slot' => 'phq2'
    }
  ],

};
}});
$pages{'PAGE_006B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_006B',
  'next' => 'PAGE_007',
  'percent' => 21,
  'prev' => 'PAGE_006',
  'qns' => [
    {
      'slot' => 'gad1'
    },
    {
      'slot' => 'gad2'
    }
  ],

};
}});
$pages{'PAGE_007'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_007',
  'percent' => 23,
  'prev' => 'PAGE_006B',
  'qns' => [
    {
      'slot' => 'med'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  my $anxiety    = $session->get('gad1') + $session->get('gad2');
  my $depression = $session->get('phq1') + $session->get('phq2');

  my $limit = 2;

  my $timestamp = time();

  if (!$session->get('screening_complete')) {
    $session->set(screening_complete => $timestamp);
  }

  if ($session->get('med') == 0 && $anxiety < $limit && $depression < $limit) {
    if (!$session->get('ineligible')) {
      $session->set(ineligible => $timestamp);
      $session->set(out_of_study => time());
      $session->set(eligible => undef);
    }
    return 'PAGE_last_A';
  }

  if (!$session->get('eligible')) {
    $session->set(eligible => $timestamp);
    $session->set(ineligible => undef);
    $session->set(out_of_study => undef);
  }

  return 'PAGE_invite_participate_1';
},

};
}});
$pages{'PAGE_invite_participate_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_invite_participate_1',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'next' => 'PAGE_invite_participate_2',
  'percent' => 25,
  'prev' => 'PAGE_007',
  'qns' => [
    {
      'text' => '<p>Based on your answers we invite you to take part in Link-me.</p>
<p>Link-me is a <strong>[% INCLUDE glossary_link.tt2 term=\'randomised controlled trial\' text=\'randomised controlled trial\' %]</strong> testing a new approach to mental health care. It is funded by the Australian Government and is led by researchers at the University of Melbourne.</p>
',
      'tt2' => 1
    }
  ],

};
}});
$pages{'PAGE_invite_participate_2'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_invite_participate_2',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'next' => 'PAGE_invite_participate_3',
  'percent' => 27,
  'prev' => 'PAGE_invite_participate_1',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>One in two Australians will experience mental health problems in their lifetime.</p>
<p>Mental health problems can make it hard for people to live the life they want.</p>
<p>Many things can help improve mental health, but it can be hard to know what is the best option for you.</p>
<p>Link-me is testing whether a survey that\'s completed in the GP waiting room can help people improve their mental health by finding support that works for them.</p>
'
    }
  ],

};
}});
$pages{'PAGE_invite_participate_3'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_invite_participate_3',
  'percent' => 29,
  'prev' => 'PAGE_invite_participate_2',
  'qns' => [
    {
      'html' => 1,
      'text' => 'Taking part in Link-me is completely up to you, and you can withdraw (quit) at any time. If you take part we will ask you to:
<p><ul>
  <li>Fill out a short (2-5 minute) survey on this iPad. Depending on your answers you may be randomly allocated to one of two groups. Each group will be asked to do something different.</li>
  <li>Provide your contact details so that we can contact you for feedback about your mental health and mental health care in 6, 12, and 18 months.</li>
</ul></p>
<p>You can read more about Link-me by tapping the buttons below. You can also collect a more detailed information booklet from reception.</p>
'
    },
    {
      'text' => '<div class="infobox"><strong>[% INCLUDE glossary_link.tt2 term=\'What are the benefits and risks of taking part?\' text=\'What are the benefits and risks of taking part?\' %]</strong></div>
',
      'tt2' => 1
    },
    {
      'text' => '<div class="infobox"><strong>[% INCLUDE glossary_link.tt2 term=\'What will happen to information about me?\' text=\'What will happen to information about me?\' %]</strong></div>
',
      'tt2' => 1
    },
    {
      'text' => '<div class="infobox"><strong>[% INCLUDE glossary_link.tt2 term=\'Link-me and my GP\' text=\'Link-me and my GP\' %]</strong></div>
',
      'tt2' => 1
    },
    {
      'text' => '<div class="infobox"><strong>[% INCLUDE glossary_link.tt2 term=\'Link-me and my health service use\' text=\'Link-me and my health service use\' %]</strong></div>
',
      'tt2' => 1
    },
    {
      'text' => '<div class="infobox"><strong>[% INCLUDE glossary_link.tt2 term=\'Who can I contact about this trial?\' text=\'Who can I contact about this trial?\' %]</strong></div>
',
      'tt2' => 1
    },
    {
      'slot' => 'interested'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  if ($session->get('interested') == 1) {
    return 'consent';
  }

  if (!$session->get('out_of_study')) {
    $session->set(out_of_study => time());
  }

  return 'PAGE_last_A';
},

};
}});
$pages{'consent'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'consent',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Submit'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'percent' => 31,
  'prev' => 'PAGE_invite_participate_3',
  'qns' => [
    {
      'html' => 1,
      'text' => 'Getting started with Link-me is easy. Just enter your details below to show that you:
<p><ul>
  <li>agree to take part in Link-me as described </li>
  <li>agree to us updating your medical record with information relevant to your mental health care (if necessary)</li>
  <li>agree to be emailed a copy of the study information</li>
  <li>have had a chance to read the study information and have asked practice staff any questions you may have</li>
  <li>understand that you can withdraw from the trial at any time.</li>
</ul></p>
'
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
      'slot' => 'email'
    },
    {
      'slot' => 'phone'
    },
    {
      'slot' => 'address'
    }
  ],
  'next' => sub {
  # use Data::Dumper;

  my ($page, $session) = @_;

  my $conf = SD::Config->load;
  my $json = JSON::XS->new;

  # Validate duplicate registrations
  my $duplicate_sessions = $conf->{get_sessions_where}->('survey', {
    email => $session->get('email'),
  	dob   => $session->get('dob'),
  });

  # check that there is only 1 element in the array
  if (@$duplicate_sessions > 1) {
    return 'PAGE_last_B';
    # die E->new("The email address and date of birth have already been registered with Link-me.");
  }


  if (!$session->get('consent_email_sent')) {
    my $base_url    = $conf->{webserver_info}->{fe_url};
    my $session_key = $session->get('session_key');

    my $vars = {
      name => $session->get('firstname'),
      link => "$base_url/q?SD_KEY=$session_key",
    };

    $conf->{send_email}->(
      $session->get('email'),
      undef,
      'Link-me - Survey link',
      'link_me_survey_link.tx',
      $json->encode($vars),
      undef,
    );

    $session->set(consent_email_sent => time());
    $session->set(started            => time());
  }

  return 'survey_start';
},

};
}});
$pages{'survey_start'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'survey_start',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Start'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'next' => 'PAGE_008',
  'percent' => 33,
  'prev' => 'consent',
  'qns' => [
    {
      'heading' => 'Let\'s get started!'
    },
    {
      'text' => '<p>There are no right or wrong answers to these questions. If you\'re not sure which answer to give, the first one you think of is often the best.</p>
<p>Please answer all the questions, even if some seem very similar to each other.</p>
',
      'tt2' => 1
    }
  ],

};
}});
$pages{'PAGE_008'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_008',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'next' => 'PAGE_008B',
  'percent' => 35,
  'prev' => 'survey_start',
  'qns' => [
    {
      'slot' => 'gp'
    },
    {
      'slot' => 'gp_other'
    },
    {
      'slot' => 'gp_reason'
    }
  ],

};
}});
$pages{'PAGE_008B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_008B',
  'next' => 'PAGE_008C',
  'percent' => 37,
  'prev' => 'PAGE_008',
  'qns' => [
    {
      'slot' => 'sf1_health'
    },
    {
      'slot' => 'chronic'
    }
  ],

};
}});
$pages{'PAGE_008C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_008C',
  'next' => 'PAGE_009',
  'percent' => 39,
  'prev' => 'PAGE_008B',
  'qns' => [
    {
      'slot' => 'live_alone'
    },
    {
      'slot' => 'inc_mg'
    }
  ],

};
}});
$pages{'PAGE_009'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_009',
  'next' => 'PAGE_009B',
  'percent' => 41,
  'prev' => 'PAGE_008C',
  'qns' => [
    {
      'slot' => 'phq3'
    },
    {
      'slot' => 'phq4'
    },
    {
      'slot' => 'phq5'
    }
  ],

};
}});
$pages{'PAGE_009B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_009B',
  'next' => 'PAGE_009C',
  'percent' => 43,
  'prev' => 'PAGE_009',
  'qns' => [
    {
      'slot' => 'phq6'
    },
    {
      'slot' => 'phq7'
    }
  ],

};
}});
$pages{'PAGE_009C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_009C',
  'next' => 'PAGE_010',
  'percent' => 45,
  'prev' => 'PAGE_009B',
  'qns' => [
    {
      'slot' => 'phq8'
    },
    {
      'slot' => 'phq9'
    }
  ],

};
}});
$pages{'PAGE_010'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_010',
  'next' => 'PAGE_011',
  'percent' => 47,
  'prev' => 'PAGE_009C',
  'qns' => [
    {
      'slot' => 'ever_down'
    },
    {
      'slot' => 'ever_nointerest'
    }
  ],

};
}});
$pages{'PAGE_011'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_011',
  'next' => 'PAGE_011B',
  'percent' => 49,
  'prev' => 'PAGE_010',
  'qns' => [
    {
      'slot' => 'gad3'
    },
    {
      'slot' => 'gad4'
    }
  ],

};
}});
$pages{'PAGE_011B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_011B',
  'next' => 'PAGE_011C',
  'percent' => 50,
  'prev' => 'PAGE_011',
  'qns' => [
    {
      'slot' => 'gad5'
    },
    {
      'slot' => 'gad6'
    }
  ],

};
}});
$pages{'PAGE_011C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_011C',
  'next' => 'PAGE_012',
  'percent' => 52,
  'prev' => 'PAGE_011B',
  'qns' => [
    {
      'slot' => 'gad7'
    }
  ],

};
}});
$pages{'PAGE_012'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_012',
  'next' => 'PAGE_012B',
  'percent' => 54,
  'prev' => 'PAGE_011C',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Tap the response that best describes your health <strong>today</strong>.</p>
'
    },
    {
      'slot' => 'eq1'
    },
    {
      'slot' => 'eq2'
    }
  ],

};
}});
$pages{'PAGE_012B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_012B',
  'next' => 'PAGE_012C',
  'percent' => 56,
  'prev' => 'PAGE_012',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Tap the response that best describes your health <strong>today</strong>.</p>
'
    },
    {
      'slot' => 'eq3'
    }
  ],

};
}});
$pages{'PAGE_012C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_012C',
  'next' => 'PAGE_013',
  'percent' => 58,
  'prev' => 'PAGE_012B',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Tap the response that best describes your health <strong>today</strong>.</p>
'
    },
    {
      'slot' => 'eq4'
    },
    {
      'slot' => 'eq5'
    }
  ],

};
}});
$pages{'PAGE_013'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_013',
  'next' => 'PAGE_014',
  'percent' => 60,
  'prev' => 'PAGE_012C',
  'qns' => [
    {
      'slot' => 'healthrange'
    },
    {
      'slot' => 'eq_vas'
    }
  ],

};
}});
$pages{'PAGE_014'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_014',
  'next' => 'PAGE_014B',
  'percent' => 62,
  'prev' => 'PAGE_013',
  'qns' => [
    {
      'slot' => 'k1'
    },
    {
      'slot' => 'k2'
    }
  ],

};
}});
$pages{'PAGE_014B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_014B',
  'next' => 'PAGE_014C',
  'percent' => 64,
  'prev' => 'PAGE_014',
  'qns' => [
    {
      'slot' => 'k3'
    },
    {
      'slot' => 'k4'
    }
  ],

};
}});
$pages{'PAGE_014C'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_014C',
  'next' => 'PAGE_015',
  'percent' => 66,
  'prev' => 'PAGE_014B',
  'qns' => [
    {
      'slot' => 'k5'
    },
    {
      'slot' => 'k6'
    }
  ],

};
}});
$pages{'PAGE_015'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_015',
  'next' => 'PAGE_015B',
  'percent' => 68,
  'prev' => 'PAGE_014C',
  'qns' => [
    {
      'slot' => 'k7'
    },
    {
      'slot' => 'k8'
    }
  ],

};
}});
$pages{'PAGE_015B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_015B',
  'percent' => 70,
  'prev' => 'PAGE_015',
  'qns' => [
    {
      'slot' => 'k9'
    },
    {
      'slot' => 'k10'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  my $k1 = $session->get('k1');
  my $k2 = $session->get('k2');
  my $k3 = $session->get('k3');
  my $k4 = $session->get('k4');
  my $k5 = $session->get('k5');
  my $k6 = $session->get('k6');
  my $k7 = $session->get('k7');
  my $k8 = $session->get('k8');
  my $k9 = $session->get('k9');
  my $k10 = $session->get('k10');

  if ( $k1 == 1 && $k2 == 1 && $k3 == 1 && $k4 == 1 && $k5 == 1 && $k6 == 1 && $k7 == 1 && $k8 == 1 && $k9 == 1 && $k10 == 1 ) {
      # Calculate the things
      my $conf = SD::Config->load;

      my $group = $session->get('group');

      if (!$session->get('severity')) {
        my $severity_level = $conf->{calculate_severity}->($session);
        $session->set(severity => $severity_level);

        # Moderate is *always* control.
        if ($severity_level =~ m/^Moderate/) {
          $group = 'control';
          $session->set(group => 'control');
        }

        if (!$group) { # Randomize Mild/Severe severity groups
          $group = $conf->{get_group}->($session);
          $session->set(group => $group);
        }
      }

      my $ok_areas = $conf->{get_ok_areas}->($session);
      if ($group eq 'intervention') {
        if (@$ok_areas == 0) {
          return 'PAGE_intervention_3';
        } else {
          return 'PAGE_intervention_1';
        }
      } else {
        return 'PAGE_control_last';
      }
  } else {
     return 'PAGE_016';
  }
},

};
}});
$pages{'PAGE_016'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_016',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'next' => 'PAGE_016B',
  'percent' => 72,
  'prev' => 'PAGE_015B',
  'qns' => [
    {
      'slot' => 'k11'
    },
    {
      'slot' => 'k12'
    }
  ],

};
}});
$pages{'PAGE_016B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_016B',
  'nav' => [
    {
      'first' => 'Home'
    },
    {
      'next' => 'Next'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'percent' => 74,
  'prev' => 'PAGE_016',
  'qns' => [
    {
      'slot' => 'k13'
    },
    {
      'slot' => 'k14'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf = SD::Config->load;

  my $group = $session->get('group');

  if (!$session->get('severity')) {
    my $severity_level = $conf->{calculate_severity}->($session);
    $session->set(severity => $severity_level);

    # Moderate is *always* control.
    if ($severity_level =~ m/^Moderate/) {
      $group = 'control';
      $session->set(group => 'control');
    }

    if (!$group) {
      $group = $conf->{get_group}->($session);
      $session->set(group => $group);
    }
  }

  my $ok_areas = $conf->{get_ok_areas}->($session);
  if ($group eq 'intervention') {
    if (@$ok_areas == 0) {
      return 'PAGE_intervention_3';
    } else {
      return 'PAGE_intervention_1';
    }
  } else {
    return 'PAGE_control_last';
  }
},

};
}});
$pages{'PAGE_intervention_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_1',
  'percent' => 76,
  'prev' => 'PAGE_016B',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Thank you for completing the Link-me survey!</p>
<p>Your GP is here to help you with any concerns you may have about your mental health. We will also send you an email with some other services that are available 24 hours a day.</p>
<p>From what you have told us, things seem to be ok for you in these areas right now:</p>
'
    },
    {
      'text' => '[% PROCESS intervention_ok_areas %]',
      'tt2' => 1
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf = SD::Config->load;
  my $difficult_areas = $conf->{get_difficult_areas}->($session);

  my $severity = $session->get('severity');

  if (@$difficult_areas == 0) {
    if ($severity =~ m/^Mild/) {
      return 'PAGE_intervention_low';
    } else {
      return 'PAGE_intervention_high';
    }
  } else {
    return 'PAGE_intervention_3';
  }
},

};
}});
$pages{'PAGE_intervention_3'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_3',
  'percent' => 78,
  'prev' => 'PAGE_intervention_1',
  'qns' => [
    {
      'text' => '[% PROCESS intervention_difficult_areas %]',
      'tt2' => 1
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf = SD::Config->load;
  my $difficult_areas = $conf->{get_difficult_areas}->($session);

  my $severity = $session->get('severity');

  if (@$difficult_areas <= 2) {
    return 'PAGE_intervention_5';
  } else {
    return 'PAGE_intervention_4';
  }
},

};
}});
$pages{'PAGE_intervention_4'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_4',
  'next' => 'PAGE_intervention_5',
  'percent' => 80,
  'prev' => 'PAGE_intervention_3',
  'qns' => [
    {
      'text' => '<h1 align="center">Areas of difficulty</h1>
<p>It looks like there are a few areas that are difficult for you at the moment. No one can do everything at once, so why not pick one or two of these areas to focus on first. Once you feel like these areas of your life are more in control, you can choose something else to focus on.</p>
',
      'tt2' => 1
    },
    {
      'slot' => 'q2'
    }
  ],

};
}});
$pages{'PAGE_intervention_5'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_5',
  'percent' => 82,
  'prev' => 'PAGE_intervention_4',
  'qns' => [
    {
      'text' => '[%- INCLUDE difficult_areas_scale_text -%]
',
      'tt2' => 1
    },
    {
      'slot' => 'motivation'
    },
    {
      'slot' => 'confidence'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf = SD::Config->load;

  my $severity_level = $session->get('severity');

  if ($severity_level eq 'Mild_D' || $severity_level eq 'Mild_A' || $severity_level eq 'Mild_DA') {
    return 'PAGE_intervention_low';
  } elsif ($severity_level eq 'Severe_D' || $severity_level eq 'Severe_A' || $severity_level eq 'Severe_DA') {
    return 'PAGE_intervention_high';
  } else {
    return 'PAGE_control_last';
  }
},

};
}});
$pages{'PAGE_intervention_low'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_low',
  'nav' => [
    {
      'next' => 'Next'
    }
  ],
  'next' => 'PAGE_last_A',
  'percent' => 84,
  'prev' => 'PAGE_intervention_5',
  'qns' => [
    {
      'text' => '[%- INCLUDE difficult_areas_text -%]
<p>When you are ready, please click \'Next\' and we will send you an email with a link to find out more about these options and decide which one might be right for you. You might also like to discuss these options with your GP.</p>
',
      'tt2' => 1
    },
    {
      'text' => '[% PROCESS resources %]',
      'tt2' => 1
    }
  ],

};
}});
$pages{'PAGE_intervention_high'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_intervention_high',
  'nav' => [
    {
      'next' => 'Next'
    }
  ],
  'next' => 'PAGE_last_A',
  'percent' => 86,
  'prev' => 'PAGE_intervention_low',
  'qns' => [
    {
      'text' => '<input type="hidden" id="anxiety_predict" name="anxiety_predict" value="[% session.get(\'anxiety_predict\') %]" />
<input type="hidden" id="depression_predict" name="depression_predict" value="[% session.get(\'depression_predict\') %]" />
<p>To help with your [%- INCLUDE difficult_areas -%], we think you might benefit from working together with the Link-me navigator and your GP.</p>
<p>The Link-me navigator is a health professional who is specially trained to work closely with you and your GP to help you identify and access the right support to keep you well.</p>
<p>As part of Link-me you\'re invited to have up to eight free appointments with the Link-me navigator to find an approach to mental health care that works for you.</p>
<p>The Link-me navigator will give you a call in the next couple of days to talk more about this service and to schedule your first appointment. </p>
',
      'tt2' => 1
    }
  ],

};
}});
$pages{'PAGE_control_last'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_control_last',
  'nav' => [
    {
      'next' => 'Finish'
    }
  ],
  'percent' => 88,
  'prev' => 'PAGE_intervention_high',
  'qns' => [
    {
      'text' => '<input type="hidden" id="anxiety_predict" name="anxiety_predict" value="[% session.get(\'anxiety_predict\') %]" />
<input type="hidden" id="depression_predict" name="depression_predict" value="[% session.get(\'depression_predict\') %]" />
<p>Thank you for completing the Link-me survey!</p>
<p>Your GP is here to help you with any concerns you may have about your mental health. We will also send you an email with some other services that are available 24 hours a day.</p>
<p>Link-me is your chance to have a say in how mental health care is delivered in Australia. We will check in with you in about six months\' time to ask about your experience of mental health care in your area.</p>
<p>In the meantime, if you have any questions please contact us - you can find our details at reception or on the email we have sent you.</p>
<p><strong>Please return this iPad to reception.</strong></p>
',
      'tt2' => 1
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $config = SD::Config->load;

  $config->{send_completion_email}->($session);

  # Don't store difficult areas as control.
  # As Susie doesn't want them on admin site.
  # $config->{store_list_difficult}->($session);

  $session->set(completed => time());
  return 'completed';
},

};
}});
$pages{'PAGE_last_A'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_last_A',
  'nav' => [
    {
      'next' => 'Finish'
    }
  ],
  'percent' => 90,
  'prev' => 'PAGE_control_last',
  'qns' => [
    {
      'text' => '<input type="hidden" id="anxiety_predict" name="anxiety_predict" value="[% session.get(\'anxiety_predict\') %]" />
<input type="hidden" id="depression_predict" name="depression_predict" value="[% session.get(\'depression_predict\') %]" />
<p>Thank you for your time today.</p>
<p>Your answers will help us to improve care for mental health and wellbeing in Australia.</p>
<p><strong>Please return this iPad to reception.</strong></p>
<p>Link-me is a collaboration between the University of Melbourne and the Brisbane North, North Coast, and North Western Melbourne Primary Health Networks. The trial is funded by the Australian Government Department of Health.</p>
<p>If you have any questions about the study, please contact us at <a href="mailto:link-me@unimelb.edu.au">link-me@unimelb.edu.au</a>.</p>
',
      'tt2' => 1
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $config     = SD::Config->load;
  my $send_email = !($session->get('ineligible') || $session->get('out_of_study'));

  if ($send_email) {
    $config->{send_completion_email}->($session);
    $config->{store_list_difficult}->($session);
  }

  $session->set(completed => time());
  return 'completed';
},

};
}});
$pages{'PAGE_last_B'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_last_B',
  'nav' => [
    {
      'next' => 'Finish'
    }
  ],
  'percent' => 92,
  'prev' => 'PAGE_last_A',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Thanks for your interest in Link-me. Based on the information you\'ve provided it looks like you\'re already registered for the trial. If you think this is a mistake, please contact us using the details we have just sent you via email.</p>
<p><strong>Please return this iPad to reception.</strong></p>
<p>Link-me is a collaboration between the University of Melbourne and the Brisbane North, North Coast, and North Western Melbourne Primary Health Networks. The trial is funded by the Australian Government Department of Health.</p>
<p>If you have any questions about the study, please contact us at <a href="mailto:link-me@unimelb.edu.au">link-me@unimelb.edu.au</a>.</p>
'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf = SD::Config->load;
  my $json = JSON::XS->new;

  my $vars = {
    name => $session->get('firstname'),
  };

  $conf->{send_email}->(
    $session->get('email'),
    undef,
    'Thanks for your interest in Link-me',
    'link_me_already_completed.tx',
    $json->encode($vars),
    undef,
  );

  $session->set(completed => time());
  return 'completed';
},

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
      'next' => 'Submit'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'percent' => 99,
  'prev' => 'PAGE_last_B',
  'qns' => [
    {
      'text' => '[% PROCESS last %]',
      'tt2' => 1
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;
  $session->set(completed => time());
  return 'completed';
},

};
}});
$pages{'redirect_to_default'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'redirect_to_default',
  'next' => 'redirect_to_create_new_session',
  'percent' => 96,
  'prev' => 'last',
  'template' => 'redirect_to_default',

};
}});
$pages{'redirect_to_create_new_session'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'redirect_to_create_new_session',
  'next' => 'last',
  'percent' => 98,
  'prev' => 'redirect_to_default',
  'template' => 'redirect_to_create_new_session',

};
}});


my $lasts_prev_name = 'redirect_to_create_new_session';

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

# y2p 2017-11-01T20:57:25 1
