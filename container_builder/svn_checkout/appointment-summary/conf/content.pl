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
$slots{'venue'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Venue',
  'name' => 'venue',
  'options' => [
    {
      '1' => 'Client\'s Home'
    },
    {
      '2' => 'Service provider\'s office'
    },
    {
      '3' => 'GP Practice'
    },
    {
      '4' => 'Other medical practice'
    },
    {
      '5' => 'Headspace Centre'
    },
    {
      '6' => 'Other primary care setting'
    },
    {
      '7' => 'Public or private hospital'
    },
    {
      '8' => 'Aged care centre'
    },
    {
      '9' => 'School or other educational centre'
    },
    {
      '10' => 'Client\'s Workplace'
    },
    {
      '11' => 'Other'
    },
    {
      '98' => 'Not applicable (Service Contact Modality is not face to face)'
    },
    {
      '99' => 'Not stated'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 1 => "Client's Home" }, { 2 => "Service provider's office" }, { 3 => 'GP Practice' }, { 4 => 'Other medical practice' }, { 5 => 'Headspace Centre' }, { 6 => 'Other primary care setting' }, { 7 => 'Public or private hospital' }, { 8 => 'Aged care centre' }, { 9 => 'School or other educational centre' }, { 10 => "Client's Workplace" }, { 11 => 'Other' }, { 98 => 'Not applicable (Service Contact Modality is not face to face)' }, { 99 => 'Not stated' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 1 => "Client's Home", 2 => "Service provider's office", 3 => 'GP Practice', 4 => 'Other medical practice', 5 => 'Headspace Centre', 6 => 'Other primary care setting', 7 => 'Public or private hospital', 8 => 'Aged care centre', 9 => 'School or other educational centre', 10 => "Client's Workplace", 11 => 'Other', 98 => 'Not applicable (Service Contact Modality is not face to face)', 99 => 'Not stated'}
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
$slots{'type'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Type',
  'name' => 'type',
  'options' => [
    {
      '1' => 'Assessment'
    },
    {
      '4' => 'Clinical care coordination/liaison'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 1 => 'Assessment' }, { 4 => 'Clinical care coordination/liaison' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 1 => 'Assessment', 4 => 'Clinical care coordination/liaison' }
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
$slots{'rescheduling_cancellation_notes'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'Rescheduling / cancellation notes:',
  'name' => 'rescheduling_cancellation_notes',
  'rows' => 2,

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
$slots{'participants'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Participants',
  'name' => 'participants',
  'options' => [
    {
      '1' => 'Individual client'
    },
    {
      '2' => 'Client group'
    },
    {
      '3' => 'Family / Client Support Network'
    },
    {
      '4' => 'Other health professional or service provider'
    },
    {
      '5' => 'Other'
    },
    {
      '9' => 'Not stated'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { { 1 => 'Individual client' }, { 2 => 'Client group' }, { 3 => 'Family / Client Support Network' }, { 4 => 'Other health professional or service provider' }, { 5 => 'Other' }, { 9 => 'Not stated' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 1 => 'Individual client', 2 => 'Client group', 3 => 'Family / Client Support Network', 4 => 'Other health professional or service provider', 5 => 'Other', 9 => 'Not stated' }
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
$slots{'modality'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Modality',
  'name' => 'modality',
  'options' => [
    {
      '0' => 'No contact took place'
    },
    {
      '1' => 'Face to Face'
    },
    {
      '2' => 'Telephone'
    },
    {
      '3' => 'Video'
    },
    {
      '4' => 'Internet-based'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No contact took place' }, { 1 => 'Face to Face' }, { 2 => 'Telephone' }, { 3 => 'Video' }, { 4 => 'Internet-based' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No contact took place', 1 => 'Face to Face', 2 => 'Telephone', 3 => 'Video', 4 => 'Internet-based' }
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
$slots{'interpreter_used'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Interpreter used',
  'name' => 'interpreter_used',
  'options' => [
    {
      '1' => 'Yes'
    },
    {
      '2' => 'No'
    },
    {
      '3' => 'Not stated'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 1 => 'Yes' }, { 2 => 'No' }, { 3 => 'Not stated' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 1 => 'Yes', 2 => 'No', 3 => 'Not stated'}
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
$slots{'duration'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'label' => 'Duration',
  'name' => 'duration',
  'options' => [
    {
      '0' => 'No contact took place'
    },
    {
      '1' => '1-15 mins'
    },
    {
      '2' => '16-30 mins'
    },
    {
      '3' => '31-45 mins'
    },
    {
      '4' => '46-60 mins'
    },
    {
      '5' => '61-75 mins'
    },
    {
      '6' => '76-90 mins'
    },
    {
      '8' => '92-105 mins'
    },
    {
      '8' => '106-120 mins'
    },
    {
      '9' => 'over 120 mins'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 0 => 'No contact took place' }, { 1 => '1-15 mins' }, { 2 => '16-30 mins' }, { 3 => '31-45 mins' }, { 4 => '46-60 mins' }, { 5 => '61-75 mins' }, { 6 => '76-90 mins' }, { 7 => '91-105 mins' }, { 8 => '106-120 mins' }, { 9 => 'over 120 mins' } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 0 => 'No contact took place', 1 => '1-15 mins', 2 => '16-30 mins', 3 => '31-45 mins', 4 => '46-60 mins', 5 => '61-75 mins', 6 => '76-90 mins', 7 => '91-105 mins', 8 => '106-120 mins', 9 => 'over 120 mins'}
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
$slots{'cost_phn'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'instructions' => 'Please enter numbers only',
  'label' => {
    'position' => 'left',
    'text' => '$'
  },
  'name' => 'cost_phn',

};
}});
$slots{'contact_went_well'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => 'What about this contact went well?',
  'name' => 'contact_went_well',
  'rows' => 2,

};
}});
$slots{'contact_not_well'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'cols' => 80,
  'label' => "What about this contact didn\x{2019}t go well?",
  'name' => 'contact_not_well',
  'rows' => 2,

};
}});
$slots{'care_package_type_other'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'If \'Other additional service\', please specify:',
  'name' => 'care_package_type_other',
  'size' => 80,

};
}});
$slots{'care_package_type'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'class' => 'ynd',
  'label' => 'Care package type',
  'name' => 'care_package_type',
  'options' => [
    {
      '1' => 'Support service - vocational'
    },
    {
      '2' => 'Support service - educational'
    },
    {
      '3' => 'Support service - housing related'
    },
    {
      '4' => 'Support service - other'
    },
    {
      '5' => 'Family therapy / counselling'
    },
    {
      '6' => 'Nutritionist'
    },
    {
      '7' => 'Dietitian'
    },
    {
      '8' => 'Exercise physiologist'
    },
    {
      '9' => 'Other allied health service'
    },
    {
      '10' => 'MBS gap payment - psychiatrist'
    },
    {
      '11' => 'MBS gap payment - psychologist'
    },
    {
      '12' => 'MBS gap payment - GP'
    },
    {
      '13' => 'MBS gap payment - other allied health'
    },
    {
      '99' => 'Other additional service (specify)'
    }
  ],
  'widget' => 'choice_v_altvals',
  'check' => sub {
  my ($self, $val) = @_;
  # options is: [ { 1 => "Support service - vocational" }, { 2 => "Support service - educational" }, { 3 => "Support service - housing related" }, { 4 => "Support service - other" }, { 5 => "Family therapy / counselling" }, { 6 => "Nutritionist" }, { 7 => "Dietitian" }, { 8 => "Exercise physiologist" }, { 9 => "Other allied health service" }, { 10 => "MBS gap payment - psychiatrist" }, { 11 => "MBS gap payment - psychologist" }, { 12 => "MBS gap payment - GP" }, { 13 => "MBS gap payment - other allied health" }, { 99 => "Other additional service (specify)" } ]
  my %opts = map { %$_ } @{ $self->options };
  #  %opts: { 1 => "Support service - vocational", 2 => "Support service - educational", 3 => "Support service - housing related", 4 => "Support service - other", 5 => "Family therapy / counselling", 6 => "Nutritionist", 7 => "Dietitian", 8 => "Exercise physiologist", 9 => "Other allied health service", 10 => "MBS gap payment - psychiatrist", 11 => "MBS gap payment - psychologist", 12 => "MBS gap payment - GP", 13 => "MBS gap payment - other allied health", 99 => "Other additional service (specify)" }
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
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'no_show'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'No Show',
  'name' => 'no_show',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'final'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'Final',
  'name' => 'final',
  'options' => [
    'No further services are planned for the client in the current episode',
    'Further services are planned for the client in the current episode',
    'Not known at this stage'
  ],

};
}});
$slots{'client_participation_indicator'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'Client participation indicator',
  'name' => 'client_participation_indicator',
  'options' => [
    'Yes',
    'No'
  ],

};
}});
$slots{'c_h'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_h',
  'widget' => 'choice_h',

};
}});
$slots{'appointment_date'} = SD::Slot::date->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Date'
  },
  'mandatory' => 1,
  'name' => 'appointment_date',
  'picker' => 'none',

};
}});



# -----PAGES----- $page_code output:
$pages{'start'} = SD::Page->new(do {{
my $VAR1 = {
  'first' => 0,
  'name' => 'start',
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
  'percent' => 0,
  'portal' => 'redirect_to_admin',
  'prev' => 0,
  'qns' => [
    {
      'heading' => 'Appointment Summary'
    },
    {
      'slot' => 'appointment_date'
    },
    {
      'slot' => 'rescheduling_cancellation_notes'
    },
    {
      'slot' => 'client_participation_indicator'
    },
    {
      'slot' => 'duration'
    },
    {
      'slot' => 'final'
    },
    {
      'slot' => 'interpreter_used'
    },
    {
      'slot' => 'modality'
    },
    {
      'slot' => 'no_show'
    },
    {
      'slot' => 'participants'
    },
    {
      'slot' => 'type'
    },
    {
      'slot' => 'venue'
    },
    {
      'slot' => 'care_package_type'
    },
    {
      'slot' => 'care_package_type_other'
    },
    {
      'html' => 1,
      'text' => '<strong>Cost to PHN (Enter in whole dollars)</strong>'
    },
    {
      'slot' => 'cost_phn'
    },
    {
      'slot' => 'contact_went_well'
    },
    {
      'slot' => 'contact_not_well'
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
  'prev' => 'start',
  'qns' => [
    {
      'text' => '[% PROCESS last %]',
      'tt2' => 1
    }
  ],
  'summary_view' => 0,
  'next' => sub { $_[1]->set(completed=>time()); 'completed' },

};
}});
$pages{'redirect_to_admin'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'redirect_to_admin',
  'next' => 'last',
  'percent' => 66,
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

# y2p 2017-11-01T14:11:54 1
