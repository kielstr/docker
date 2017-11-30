#!/usr/bin/env perl

use strict;
use warnings;
use Minion;
use Data::Dumper 'Dumper';
use Env qw(CONNECTION_STRING NUMBER_OF_JOBS);
use feature 'say';

say "CONNECTION_STRING: $CONNECTION_STRING";
say "NUMBER_OF_JOBS: $NUMBER_OF_JOBS";

my $minion = Minion->new( Pg => $CONNECTION_STRING );

$minion->add_task(build_img => sub {
  my ( $job, @args ) = @_;
  
  say "$$ running build_img: args, @args";
  sleep 10;
  say "$$ done...";
});

my $worker = $minion->worker;

$worker->status->{jobs} = $NUMBER_OF_JOBS;

say "Minion worker starting.";
$worker->run;
