#!/usr/bin/env perl

use v5.18;

use strict;
use warnings;

use YAML::XS qw/DumpFile/;
use Text::CSV::Slurp;
use Data::Printer;

my %resource_data;
my @errors;

my $gp_csv_file = $ARGV[0];

my $slurp       = Text::CSV::Slurp->new;
my $csv_data    = $slurp->load(file => $gp_csv_file);

my %gp_map = ();

for my $row (@$csv_data) {
  my $phn    = $row->{PHN};
  my $clinic = $row->{Clinic};

  if (not exists $gp_map{$phn}{$clinic}) {
    $gp_map{$phn}{$clinic} = [];
  }

  push @{ $gp_map{$phn}{$clinic} }, $row->{GP};
}

DumpFile 'gps.yaml', \%gp_map;
