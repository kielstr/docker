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
$slots{'worked_bothered_hours'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'hours on'
  },
  'name' => 'worked_bothered_hours',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('worked_bothered') == 1;
  return 0;
},

};
}});
$slots{'worked_bothered_days'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'days in past 6 months'
  },
  'name' => 'worked_bothered_days',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('worked_bothered') == 1;
  return 0;
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
$slots{'service_self_times'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many times did you use this service?',
  'name' => 'service_self_times',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_self') == 1;
  return 0;
},

};
}});
$slots{'service_self_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'service_self_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_self') == 1;
  return 0;
},

};
}});
$slots{'service_online_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Please specify',
  'name' => 'service_online_specify',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_online') == 1;
  return 0;
},

};
}});
$slots{'service_online_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'service_online_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_online') == 1;
  return 0;
},

};
}});
$slots{'service_hospital_times'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many times did you use this service?',
  'name' => 'service_hospital_times',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_hospital') == 1;
  return 0;
},

};
}});
$slots{'service_hospital_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'service_hospital_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_hospital') == 1;
  return 0;
},

};
}});
$slots{'service_app_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Please specify',
  'name' => 'service_app_specify',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_app') == 1;
  return 0;
},

};
}});
$slots{'service_app_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'service_app_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_app') == 1;
  return 0;
},

};
}});
$slots{'service_ambulance_times'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many times did you use this service?',
  'name' => 'service_ambulance_times',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_ambulance') == 1;
  return 0;
},

};
}});
$slots{'service_ambulance_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'service_ambulance_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('service_ambulance') == 1;
  return 0;
},

};
}});
$slots{'seen_psychologist_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_psychologist_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychologist') == 1;
  return 0;
},

};
}});
$slots{'seen_psychologist_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_psychologist_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychologist') == 1;
  return 0;
},

};
}});
$slots{'seen_psychiatrist_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_psychiatrist_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychiatrist') == 1;
  return 0;
},

};
}});
$slots{'seen_psychiatrist_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_psychiatrist_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychiatrist') == 1;
  return 0;
},

};
}});
$slots{'seen_other_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_other_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other') == 1;
  return 0;
},

};
}});
$slots{'seen_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Please specify',
  'name' => 'seen_other_specify',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other') == 1;
  return 0;
},

};
}});
$slots{'seen_other_pro_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_other_pro_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other_pro') == 1;
  return 0;
},

};
}});
$slots{'seen_other_pro_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Please specify',
  'name' => 'seen_other_pro_specify',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other_pro') == 1;
  return 0;
},

};
}});
$slots{'seen_other_pro_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_other_pro_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other_pro') == 1;
  return 0;
},

};
}});
$slots{'seen_other_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_other_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other') == 1;
  return 0;
},

};
}});
$slots{'seen_nurse_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_nurse_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_nurse_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_nurse_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_mh_nurse_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_mh_nurse_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_mh_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_mh_nurse_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_mh_nurse_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_mh_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_gp_visits'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Number of visits',
  'name' => 'seen_gp_visits',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_gp') == 1;
  return 0;
},

};
}});
$slots{'seen_gp_money'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'seen_gp_money',
  'qn_heading' => {
    'html' => 1,
    'text' => 'On average <u>how much did you pay of your own money</u> each time you used this service? (if applicable)'
  },
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_gp') == 1;
  return 0;
},

};
}});
$slots{'scale_10_important'} = SD::Slot::choice->new(do {{
my $VAR1 = {
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
$slots{'off_work_unpaid_hours'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'hours on'
  },
  'name' => 'off_work_unpaid_hours',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('off_work_unpaid') == 1;
  return 0;
},

};
}});
$slots{'off_work_unpaid_days'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'days in past 6 months'
  },
  'name' => 'off_work_unpaid_days',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('off_work_unpaid') == 1;
  return 0;
},

};
}});
$slots{'off_work_paid_hours'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'hours on'
  },
  'name' => 'off_work_paid_hours',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('off_work_paid') == 1;
  return 0;
},

};
}});
$slots{'off_work_paid_days'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'right',
    'text' => 'days in past 6 months'
  },
  'name' => 'off_work_paid_days',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('off_work_paid') == 1;
  return 0;
},

};
}});
$slots{'med'} = $slots{y_n_v}->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Do you take any medication for your <u>mental health</u>?'
  },
  'name' => 'med',

};
}});
$slots{'mc_v'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_v',
  'widget' => 'choice_v',

};
}});
$slots{'mc_h'} = SD::Slot::multichoice->new(do {{
my $VAR1 = {
  'name' => 'mc_h',
  'widget' => 'choice_h',

};
}});
$slots{'k13'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'In the <u><em>last four weeks</em></u>, how many times have you seen a doctor or any other health professional about these feelings?'
  },
  'name' => 'k13',
  'size' => 4,

};
}});
$slots{'k12'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Aside from those days, in the <u><em>last four weeks</em></u>, how many days were you able to work, study, or manage your day to day activities, but had to <u>cut down</u> on what you did because of these feelings?'
  },
  'name' => 'k12',
  'size' => 4,

};
}});
$slots{'k11'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'In the <u><em>last four weeks</em></u>, how many days were you <u>totally unable</u> to work, study, or manage your day to day activities because of these feelings?'
  },
  'name' => 'k11',
  'size' => 4,

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
$slots{'healthrange'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'name' => 'healthrange',
  'widget' => 'range',

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
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'worked_bothered'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'worked_bothered',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'service_self'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'service_self',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'service_online'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'service_online',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'service_hospital'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'service_hospital',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'service_app'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'service_app',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'service_ambulance'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'service_ambulance',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_psychologist_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_psychologist_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychologist') == 1;
  return 0;
},

};
}});
$slots{'seen_psychologist'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_psychologist',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_psychiatrist_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_psychiatrist_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_psychiatrist') == 1;
  return 0;
},

};
}});
$slots{'seen_psychiatrist'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_psychiatrist',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_other_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_other_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other') == 1;
  return 0;
},

};
}});
$slots{'seen_other_pro_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_other_pro_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_other_pro') == 1;
  return 0;
},

};
}});
$slots{'seen_other_pro'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_other_pro',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_other'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_other',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_nurse_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_nurse_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_nurse'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_nurse',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_mh_nurse_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_mh_nurse_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_mh_nurse') == 1;
  return 0;
},

};
}});
$slots{'seen_mh_nurse'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_mh_nurse',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'seen_gp_where'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Where did you see this health professional?',
  'name' => 'seen_gp_where',
  'options' => [
    'Doctor\'s room or other private practice',
    'General community health clinic',
    'Specialist community mental health clinic',
    'Community-based rehabilitation clinic',
    'Hospital outpatient clinic',
    'At a drug or alcohol service',
    'At your home'
  ],
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('seen_gp') == 1;
  return 0;
},

};
}});
$slots{'seen_gp'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'seen_gp',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'off_work_unpaid'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'off_work_unpaid',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'off_work_paid'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'off_work_paid',
  'options' => [
    'Yes',
    'No'
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
$slots{'motivation'} = $slots{c_h}->new(do {{
my $VAR1 = {
  'class' => 'single-line',
  'label' => {
    'html' => 1,
    'text' => 'On average, how much of your normal <u>work capacity</u> were you able to achieve on the days that you were bothered by mental health problems? Please select the number that fits best.'
  },
  'name' => 'motivation',
  'options' => [
    '1 None of what I would normally',
    2,
    3,
    4,
    '5 Half as much as I would normally do',
    6,
    7,
    8,
    9,
    '10 Worked at full capacity'
  ],

};
}});
$slots{'admitted_other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Please specify',
  'name' => 'admitted_other_specify',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_other¥') == 1;
  return 0;
},

};
}});
$slots{'admitted_other_reason'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => 'What was the reason for the admission?',
  'name' => 'admitted_other_reason',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_other') == 1;
  return 0;
},

};
}});
$slots{'admitted_other_nights'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many nights did you stay (counting all admissions)?',
  'name' => 'admitted_other_nights',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_other') == 1;
  return 0;
},

};
}});
$slots{'admitted_other'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'admitted_other',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'admitted_hospital_reason'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => 'What was the reason for the admission?',
  'name' => 'admitted_hospital_reason',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_hospital') == 1;
  return 0;
},

};
}});
$slots{'admitted_hospital_nights'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many nights did you stay (counting all admissions)?',
  'name' => 'admitted_hospital_nights',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_hospital') == 1;
  return 0;
},

};
}});
$slots{'admitted_hospital'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'admitted_hospital',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'admitted_PARC_reason'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => 'What was the reason for the admission?',
  'name' => 'admitted_PARC_reason',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_PARC') == 1;
  return 0;
},

};
}});
$slots{'admitted_PARC_nights'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many nights did you stay (counting all admissions)?',
  'name' => 'admitted_PARC_nights',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_PARC') == 1;
  return 0;
},

};
}});
$slots{'admitted_PARC'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'admitted_PARC',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'admitted_CCU_reason'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => 'What was the reason for the admission?',
  'name' => 'admitted_CCU_reason',
  'size' => 80,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_CCU') == 1;
  return 0;
},

};
}});
$slots{'admitted_CCU_nights'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'How many nights did you stay (counting all admissions)?',
  'name' => 'admitted_CCU_nights',
  'size' => 4,
  'mandatory' => sub {
  my ($slot, $bytes, $ses) = @_;
  return 1 if $ses->get('admitted_CCU') == 1;
  return 0;
},

};
}});
$slots{'admitted_CCU'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'name' => 'admitted_CCU',
  'options' => [
    'Yes',
    'No'
  ],

};
}});



# -----PAGES----- $page_code output:
$pages{'start'} = SD::Page->new(do {{
my $VAR1 = {
  'first' => 0,
  'name' => 'start',
  'next' => 'PAGE_001',
  'percent' => 0,
  'prev' => 0,
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>These questions concern how you have been feeling over the <u>past 30 days</u>. Select an option below each question that best represents how you have been.</p>
'
    },
    {
      'slot' => 'k1'
    },
    {
      'slot' => 'k2'
    },
    {
      'slot' => 'k3'
    }
  ],

};
}});
$pages{'PAGE_001'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_001',
  'next' => 'PAGE_002',
  'percent' => 4,
  'prev' => 'start',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>These questions concern how you have been feeling over the <u>past 30 days</u>. Select an option below each question that best represents how you have been.</p>
'
    },
    {
      'slot' => 'k4'
    },
    {
      'slot' => 'k5'
    },
    {
      'slot' => 'k6'
    }
  ],

};
}});
$pages{'PAGE_002'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_002',
  'next' => 'PAGE_003',
  'percent' => 8,
  'prev' => 'PAGE_001',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>These questions concern how you have been feeling over the <u>past 30 days</u>. Select an option below each question that best represents how you have been.</p>
'
    },
    {
      'slot' => 'k7'
    },
    {
      'slot' => 'k8'
    }
  ],

};
}});
$pages{'PAGE_003'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_003',
  'next' => 'PAGE_004',
  'percent' => 13,
  'prev' => 'PAGE_002',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>These questions concern how you have been feeling over the <u>past 30 days</u>. Select an option below each question that best represents how you have been.</p>
'
    },
    {
      'slot' => 'k9'
    },
    {
      'slot' => 'k10'
    }
  ],

};
}});
$pages{'PAGE_004'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_004',
  'next' => 'PAGE_005',
  'percent' => 17,
  'prev' => 'PAGE_003',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>The next few questions are about how these feelings may have affected you in the last four weeks. You need not answer these questions if you answered \'None of the time\' to all of the ten questions about your feelings.</p>
'
    },
    {
      'slot' => 'k11'
    },
    {
      'slot' => 'k12'
    }
  ],

};
}});
$pages{'PAGE_005'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_005',
  'next' => 'PAGE_006',
  'percent' => 21,
  'prev' => 'PAGE_004',
  'qns' => [
    {
      'slot' => 'k13'
    },
    {
      'slot' => 'k14'
    }
  ],

};
}});
$pages{'PAGE_006'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_006',
  'next' => 'PAGE_007',
  'percent' => 26,
  'prev' => 'PAGE_005',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Under each heading, please select ONE response that best describes your health <strong>today</strong>.</p>
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
$pages{'PAGE_007'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_007',
  'next' => 'PAGE_008',
  'percent' => 30,
  'prev' => 'PAGE_006',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Under each heading, please select ONE response that best describes your health <strong>today</strong>.</p>
'
    },
    {
      'slot' => 'eq3'
    }
  ],

};
}});
$pages{'PAGE_008'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_008',
  'next' => 'PAGE_009',
  'percent' => 34,
  'prev' => 'PAGE_007',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Under each heading, please select ONE response that best describes your health <strong>today</strong>.</p>
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
$pages{'PAGE_009'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_009',
  'next' => 'PAGE_010',
  'percent' => 39,
  'prev' => 'PAGE_008',
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
$pages{'PAGE_010'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_010',
  'next' => 'PAGE_011',
  'percent' => 43,
  'prev' => 'PAGE_009',
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
$pages{'PAGE_011'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_011',
  'next' => 'PAGE_012',
  'percent' => 47,
  'prev' => 'PAGE_010',
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
$pages{'PAGE_012'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_012',
  'next' => 'PAGE_013',
  'percent' => 52,
  'prev' => 'PAGE_011',
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
$pages{'PAGE_013'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_013',
  'next' => 'PAGE_014',
  'percent' => 56,
  'prev' => 'PAGE_012',
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
$pages{'PAGE_014'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_014',
  'next' => 'PAGE_015',
  'percent' => 60,
  'prev' => 'PAGE_013',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>In the past 6 months, have you seen any of the following <u>health professionals</u> because of your <u>mental health</u>?</p>
'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_gp_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_gp_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_gp_money'
        }
      ],
      'label' => 'General practitioner (GP)',
      'qn' => {
        'slot' => 'seen_gp'
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
          'slot' => 'seen_nurse_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_nurse_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_nurse_money'
        }
      ],
      'label' => 'Practice nurse',
      'qn' => {
        'slot' => 'seen_nurse'
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
          'slot' => 'seen_mh_nurse_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_mh_nurse_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_mh_nurse_money'
        }
      ],
      'label' => 'Mental health nurse',
      'qn' => {
        'slot' => 'seen_mh_nurse'
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
          'slot' => 'seen_psychiatrist_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_psychiatrist_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_psychiatrist_money'
        }
      ],
      'label' => 'Psychiatrist',
      'qn' => {
        'slot' => 'seen_psychiatrist'
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
          'slot' => 'seen_psychologist_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_psychologist_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_psychologist_money'
        }
      ],
      'label' => 'Psychologist',
      'qn' => {
        'slot' => 'seen_psychologist'
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
          'slot' => 'seen_other_pro_specify'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_pro_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_pro_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_pro_money'
        }
      ],
      'label' => 'Other Allied Health Professional (e.g. Occupational therapist, Counsellor, Social worker)',
      'qn' => {
        'slot' => 'seen_other_pro'
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
          'slot' => 'seen_other_specify'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_visits'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_where'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'seen_other_money'
        }
      ],
      'label' => 'Other',
      'qn' => {
        'slot' => 'seen_other'
      },
      'widget' => 'following_questions'
    }
  ],

};
}});
$pages{'PAGE_015'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_015',
  'next' => 'PAGE_016',
  'percent' => 65,
  'prev' => 'PAGE_014',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>In the past 6 months, have you used any of the services below for your <u>mental health</u>?</p>
'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'service_online_specify'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'service_online_money'
        }
      ],
      'label' => 'Online therapy',
      'qn' => {
        'slot' => 'service_online'
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
          'slot' => 'service_app_specify'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'service_app_money'
        }
      ],
      'label' => 'Smartphone app',
      'qn' => {
        'slot' => 'service_app'
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
          'slot' => 'service_self_times'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'service_self_money'
        }
      ],
      'label' => 'Self-help materials like (e)books/DVDs/magazines',
      'qn' => {
        'slot' => 'service_self'
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
          'slot' => 'service_ambulance_times'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'service_ambulance_money'
        }
      ],
      'label' => 'Received help from an ambulance',
      'qn' => {
        'slot' => 'service_ambulance'
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
          'slot' => 'service_hospital_times'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'service_hospital_money'
        }
      ],
      'label' => 'Attended a hospital emergency department or casualty ward',
      'qn' => {
        'slot' => 'service_hospital'
      },
      'widget' => 'following_questions'
    }
  ],

};
}});
$pages{'PAGE_016'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_016',
  'next' => 'PAGE_017',
  'percent' => 69,
  'prev' => 'PAGE_015',
  'qns' => [
    {
      'html' => 1,
      'text' => "<p>In the past 6 months, have you been admitted at least overnight to \x{2026} ?</p>
"
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_hospital_nights'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_hospital_reason'
        }
      ],
      'label' => 'A general hospital',
      'qn' => {
        'slot' => 'admitted_hospital'
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
          'slot' => 'admitted_CCU_nights'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_CCU_reason'
        }
      ],
      'label' => 'Community Care Unit (CCU)',
      'qn' => {
        'slot' => 'admitted_CCU'
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
          'slot' => 'admitted_PARC_nights'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_PARC_reason'
        }
      ],
      'label' => 'Prevention and recovery care centres (PARC)',
      'qn' => {
        'slot' => 'admitted_PARC'
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
          'slot' => 'admitted_other_specify'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_other_nights'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'admitted_other_reason'
        }
      ],
      'label' => 'Other ',
      'qn' => {
        'slot' => 'admitted_other'
      },
      'widget' => 'following_questions'
    }
  ],

};
}});
$pages{'PAGE_017'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_017',
  'next' => 'PAGE_018',
  'percent' => 73,
  'prev' => 'PAGE_016',
  'qns' => [
    {
      'slot' => 'med'
    }
  ],

};
}});
$pages{'PAGE_018'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_018',
  'next' => 'PAGE_019',
  'percent' => 78,
  'prev' => 'PAGE_017',
  'qns' => [
    {
      'html' => 1,
      'text' => 'Will need list of medicine from Melb Uni'
    }
  ],

};
}});
$pages{'PAGE_019'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_019',
  'next' => 'PAGE_020',
  'percent' => 82,
  'prev' => 'PAGE_018',
  'qns' => [
    {
      'html' => 1,
      'text' => '<p>Have you had to take <u>any time off</u> from any of your usual activities (such as paid work) in the past 6 months? Please complete the questions below regarding different types of activities.</p>
'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'off_work_paid_hours'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'off_work_paid_days'
        }
      ],
      'label' => 'Paid work',
      'qn' => {
        'slot' => 'off_work_paid'
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
          'slot' => 'off_work_unpaid_hours'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'off_work_unpaid_days'
        }
      ],
      'label' => 'Unpaid work (This may include study, voluntary work, house-keeping.)',
      'qn' => {
        'slot' => 'off_work_unpaid'
      },
      'widget' => 'following_questions'
    }
  ],

};
}});
$pages{'PAGE_020'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_020',
  'next' => 'PAGE_021',
  'percent' => 86,
  'prev' => 'PAGE_019',
  'qns' => [
    {
      'html' => 1,
      'text' => '<strong><p>During the last 6 months have there been days in which you <u>worked but were bothered</u> by mental health problems?</p></strong>
'
    },
    {
      'follow_when' => 1,
      'follow_with' => [
        {
          'qn' => undef
        },
        {
          'slot' => 'worked_bothered_hours'
        },
        {
          'qn' => undef
        },
        {
          'slot' => 'worked_bothered_days'
        }
      ],
      'qn' => {
        'slot' => 'worked_bothered'
      },
      'widget' => 'following_questions'
    }
  ],

};
}});
$pages{'PAGE_021'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_021',
  'next' => 'last',
  'percent' => 91,
  'prev' => 'PAGE_020',
  'qns' => [
    {
      'slot' => 'motivation'
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
      'next' => 'Submit'
    },
    {
      'prev' => 'Prev'
    }
  ],
  'percent' => 99,
  'prev' => 'PAGE_021',
  'qns' => [
    {
      'text' => '[% PROCESS last %]',
      'tt2' => 1
    }
  ],
  'next' => sub { $_[1]->set(completed=>time()); 'completed' },

};
}});


my $lasts_prev_name = 'last';

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

# y2p 2017-08-29T11:40:56 1
