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

$slots{'yes_no_h'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'yes_no_h',
  'options' => [
    'Yes',
    'No'
  ],
  'widget' => 'choice_h',

};
}});
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
$slots{'title_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => {
    'position' => 'aligned',
    'text' => 'If \'Other\', please specify'
  },
  'mandatory_if' => 'title',
  'name' => 'title_specify',
  'size' => 40,
  'mandatory' => sub {
    my ($slot, $bytes, $ses) = @_;
    if ($ses->get($slot->mandatory_if) == 5) {
          return 1;
    }
          return 0;
  },

};
}});
$slots{'title'} = SD::Slot::select->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Title'
  },
  'mandatory' => 1,
  'name' => 'title',
  'options' => [
    'Mr',
    'Mrs',
    'Miss',
    'Ms',
    'Other'
  ],

};
}});
$slots{'surname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Family name'
  },
  'mandatory' => 1,
  'name' => 'surname',
  'size' => 40,

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
$slots{'postal_address'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'mail-address',
  'cols' => 40,
  'label' => {
    'position' => 'aligned',
    'text' => 'Postal address (if different to above)'
  },
  'name' => 'postal_address',
  'rows' => 3,

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
$slots{'phone_check'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'class' => 'consent',
  'mandatory' => 1,
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
$slots{'othername'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Other given name(s)'
  },
  'name' => 'othername',
  'size' => 40,

};
}});
$slots{'medicare_number'} = SD::Slot::int->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'Medicare card number'
  },
  'mandatory' => 1,
  'max_val' => '99999999999',
  'min_val' => '10000000000',
  'name' => 'medicare_number',
  'size' => 11,
  'check' => sub {
  my ($self, $val) = @_;

  my $length = length($val);
  if ( ($length < 11) || ($length > 11) ) {
    die E->new( "Medicare card number should be 11 digits" );
  }
  return 1;
},

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
$slots{'firstname'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'position' => 'aligned',
    'text' => 'First given name'
  },
  'mandatory' => 1,
  'name' => 'firstname',
  'size' => 40,

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
$slots{'c_v'} = SD::Slot::choice->new(do {{
my $VAR1 = {
  'name' => 'c_v',
  'widget' => 'choice_v',

};
}});
$slots{'declaration'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'mandatory' => 1,
  'name' => 'declaration',
  'options' => [
    'I declare that the information on this form is true and correct.'
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
$slots{'authorise_primary'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'label' => 'I authorise the Department of Health to provide my primary mental health care data',
  'mandatory' => 1,
  'name' => 'authorise_primary',

};
}});
$slots{'authorise_pbs'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'PBS claims history',
  'mandatory' => 1,
  'name' => 'authorise_pbs',

};
}});
$slots{'authorise_medicare'} = $slots{yes_no}->new(do {{
my $VAR1 = {
  'class' => 'not-bold',
  'label' => 'Medicare claims history',
  'mandatory' => 1,
  'name' => 'authorise_medicare',

};
}});
$slots{'authorise_headspace'} = $slots{c_v}->new(do {{
my $VAR1 = {
  'label' => 'I authorise headspace national office to provide my headspace data',
  'mandatory' => 1,
  'name' => 'authorise_headspace',
  'options' => [
    'Yes',
    'No',
    'Not applicable, I am over 25'
  ],

};
}});
$slots{'address'} = SD::Slot::textarea->new(do {{
my $VAR1 = {
  'class' => 'mail-address',
  'cols' => 40,
  'label' => {
    'position' => 'aligned',
    'text' => 'Permanent address'
  },
  'mandatory' => 1,
  'name' => 'address',
  'rows' => 3,

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
      'heading' => 'PARTICIPANT CONSENT FORM'
    },
    {
      'html' => 1,
      'text' => '<p>Consent to release of Medicare and/or Pharmaceutical Benefits Scheme (PBS) claims information, primary mental health care information, and headspace information, for the purposes of the Link-me study</p>
<div class="infobox consent">
  <p>IMPORTANT INFORMATION</p>
  <p>Complete this form to request the release of:</p>
  <ul>
    <li>personal Medicare claims information, and/or</li>
    <li>PBS claims information, and/or</li>
    <li>primary mental health care information, and/or</li>
    <li>headspace information</li>
  </ul>
  to the Link-me Study. Incomplete forms may result in the study not being provided with your information. <strong>On the next page you will be asked what information, if any, you are willing for Link-me to access.</strong></p>
  <p>By completing this form, I acknowledge that I have been fully informed and have been provided with information about this study. I have been given an opportunity to ask questions and understand the possibilities of disclosures of my personal information.</p>
</div>
'
    },
    {
      'slot' => 'title'
    },
    {
      'slot' => 'title_specify'
    },
    {
      'slot' => 'surname'
    },
    {
      'slot' => 'firstname'
    },
    {
      'slot' => 'othername'
    },
    {
      'slot' => 'dob'
    },
    {
      'slot' => 'medicare_number'
    },
    {
      'slot' => 'address'
    },
    {
      'slot' => 'postal_address'
    }
  ],

};
}});
$pages{'PAGE_001'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_001',
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
  'percent' => 33,
  'prev' => 'start',
  'qns' => [
    {
      'heading' => 'PARTICIPANT CONSENT FORM'
    },
    {
      'html' => 1,
      'text' => '<p>Consent to release of Medicare and/or Pharmaceutical Benefits Scheme (PBS) claims information, primary mental health care information, and headspace information, for the purposes of the Link-me study</p>
<h1>AUTHORISATION</h1>
'
    },
    {
      'html' => 1,
      'text' => '<strong>I authorise the Department of Human services* to provide my:</strong>
'
    },
    {
      'slot' => 'authorise_medicare'
    },
    {
      'slot' => 'authorise_pbs'
    },
    {
      'slot' => 'authorise_primary'
    },
    {
      'slot' => 'authorise_headspace'
    },
    {
      'html' => 1,
      'text' => '<strong>For the period 01/10/2016 to 31/12/2019 to the Link-me study<br/><small></strong>*Note: The Department of Human Services can only extract 4.5 years of data (prior to the date of extraction). The consent period above may result in multiple extractions</small>
'
    },
    {
      'html' => 1,
      'text' => '<h1>DECLARATION</h1>
'
    },
    {
      'slot' => 'declaration'
    }
  ],
  'next' => sub {
  my ($page, $session) = @_;

  my $conf           = SD::Config->load;
  my $survey_session = $conf->{fetch_session}->($session->get('parent_session'), 'survey');

  my $timestamp = time();

  $survey_session->set(external_data_consent_complete => $timestamp);
  $session->set(completed => $timestamp);

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
      'prev' => 'Prev'
    },
    {
      'next' => 'Submit'
    }
  ],
  'percent' => 99,
  'prev' => 'PAGE_001',
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

# y2p 2017-10-30T11:26:15 1
