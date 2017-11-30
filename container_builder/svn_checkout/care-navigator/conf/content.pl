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
$slots{'trial_work'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'Trial work <br />(hrs)'
  },
  'name' => 'trial_work',
  'size' => 4,

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
$slots{'shift_date'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Date <br />(dd/mm/yyyy)'
  },
  'name' => 'shift_date',
  'size' => 10,

};
}});
$slots{'shift'} = SD::Slot::multi->new(do {{
my $VAR1 = {
  'button' => 'Shift',
  'class' => 'shift-log log-book',
  'element' => {
    'slot' => 'log'
  },
  'extendable' => 1,
  'name' => 'shift',
  'start_rows' => 1,
  'widget' => 'multi_list',

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
$slots{'other_specify'} = SD::Slot::text->new(do {{
my $VAR1 = {
  'label' => {
    'html' => 1,
    'text' => 'Other <br />(specify)'
  },
  'name' => 'other_specify',
  'size' => 20,

};
}});
$slots{'other'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'Other <br />(hrs)'
  },
  'name' => 'other',
  'size' => 4,

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
$slots{'log'} = SD::Slot::record->new(do {{
my $VAR1 = {
  'columns' => [
    {
      'slot' => 'shift_date'
    },
    {
      'slot' => 'clinical_work'
    },
    {
      'slot' => 'trial_work'
    },
    {
      'slot' => 'other'
    },
    {
      'slot' => 'other_specify'
    }
  ],
  'label' => {
    'text' => 'Shift [% loop.count %]',
    'tt2' => 1
  },
  'name' => 'log',
  'headings' => sub { my $self = shift; map { $_->label || undef } @{$self->columns} },

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
$slots{'clinical_work'} = SD::Slot::real->new(do {{
my $VAR1 = {
  'instructions' => 'Please enter numbers only',
  'label' => {
    'html' => 1,
    'text' => 'Clinical work <br />(hrs)'
  },
  'name' => 'clinical_work',
  'size' => 4,

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
  'next' => 'PAGE_log__book_1',
  'percent' => 0,
  'prev' => 0,
  'qns' => [
    {
      'heading' => 'Start here'
    }
  ],

};
}});
$pages{'PAGE_log__book_1'} = SD::Page->new(do {{
my $VAR1 = {
  'name' => 'PAGE_log__book_1',
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
  'prev' => 'start',
  'qns' => [
    {
      'heading' => 'Log book'
    },
    {
      'html' => 1,
      'text' => '<p>Clinical work (including patient contact, care coordination, care package research, and related admin)</p>
<p>Trial work (waiting room recruitment, contacting patients for follow-up surveys, meetings, reporting, GP emails)</p>
'
    },
    {
      'slot' => 'shift'
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
  'prev' => 'PAGE_log__book_1',
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
  'percent' => 75,
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

# y2p 2017-10-25T10:10:16 1
