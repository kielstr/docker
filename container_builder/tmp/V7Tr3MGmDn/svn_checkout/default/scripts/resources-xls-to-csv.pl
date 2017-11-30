#!/usr/bin/env perl

use Spreadsheet::XLSX;
use Text::CSV::Slurp;

use Data::Printer;

my %headers;
my %data;
my $excel = Spreadsheet::XLSX->new($ARGV[0]);

foreach my $sheet (@{$excel->{Worksheet}}) {
  my @headers;

  my $phn = $sheet->{Name};

  printf("Sheet: %s\n", $sheet->{Name});

  for my $col (0 .. $sheet->{MaxCol}) {
    my $cell = $sheet->{Cells}[0][$col];
    if ($cell) {
      push @headers, $cell->{Val};
    }
  }


  $headers{$phn} = \@headers;

  foreach my $row (1 .. $sheet->{MaxRow}) {
    my %new_row = ();

    if (!$data{$phn}) {
      $data{$phn} = [];
    }

    foreach my $col ($sheet->{MinCol} ..  $sheet->{MaxCol}) {
      my $cell = $sheet->{Cells}[$row][$col];
      if ($cell) {
        $new_row{$headers[$col]} = $cell->{Val};
      }
    }

    push @{ $data{$phn} }, \%new_row;
  }
}


my $outdir = './PHN_Resources/';

for my $phn (keys %headers) {
  my $csv = Text::CSV::Slurp->create(input => $data{$phn}, field_order => $headers{$phn});

  open my $fh, ">", "$outdir/$phn.csv" || die "Couldn't open $file $!";
  print $fh $csv;
  close $fh;
}

