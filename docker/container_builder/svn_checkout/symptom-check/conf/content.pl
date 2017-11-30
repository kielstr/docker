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
      'heading' => 'Symptom check'
    },
    {
      'text' => '[% PROCESS \'crud-summary-header\' IF summary_view %]',
      'tt2' => 1
    },
    {
      'html' => 1,
      'text' => "<p>As part of the Link-me iPad survey you completed the Kessler Psychological Distress Scale or K10. This questionnaire assesses how you\x{2019}ve been feeling over the last four weeks.</p>
"
    },
    {
      'slot' => 'k1'
    },
    {
      'slot' => 'k2'
    },
    {
      'slot' => 'k3'
    },
    {
      'slot' => 'k4'
    },
    {
      'slot' => 'k5'
    },
    {
      'slot' => 'k6'
    },
    {
      'slot' => 'k7'
    },
    {
      'slot' => 'k8'
    },
    {
      'slot' => 'k9'
    },
    {
      'slot' => 'k10'
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

# y2p 2017-10-24T11:23:22 1
