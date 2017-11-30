#!/usr/bin/env perl

use v5.18;

use strict;
use warnings;

use YAML::XS qw/DumpFile/;
use Text::CSV::Slurp;
use Data::Printer;

my %resource_data;
my @errors;


my %priority_to_id = (
  Generic => 'generic',
  Mood => 'mood',
  Sleep => 'sleep',
  Energy => 'energy',
  Appetite => 'appetite',
  Health => 'health',
  'Self-image' => 'image',
  'Little interest or pleasure in doing things' => 'interest',
  'Concentration / attention' => 'concentration',
  'Motor activity / movement' => 'movement',
  'Thoughts of death' => 'death',
  'Anxiety / worry' => 'anxiety',
  'Activities of daily life' => 'activities',
  'Household economy' => 'economy',
);

my $resources_directory = "./PHN_Resources";
my $slurp = Text::CSV::Slurp->new;

for my $filename (<$resources_directory/*.csv>) {
  my $csv_data = $slurp->load(file => $filename);

  for my $row (@$csv_data) {
    my $phn         = $row->{PHN};
    my $priority    = $row->{Priority};
    my $priority_id = $priority_to_id{$priority};

    my $phn_data = $resource_data{$phn};

    if (not exists $resource_data{$phn}{$priority_id}) {
      $resource_data{$phn}{$priority_id}= [];
    }

    push @{$resource_data{$phn}{$priority_id}}, {
      id               => $priority_id,
      priority         => $priority,
      location         => $row->{Location},
      resource_name    => $row->{Name},
      resource_details => $row->{Details},
      resource_mode    => $row->{'Type of support'},
      resource_link    => $row->{'Resource name links to'},
    };
  }
}

DumpFile 'resources.yaml', \%resource_data;
