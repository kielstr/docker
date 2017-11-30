#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper 'Dumper';

use SD::Docker;

# Set some defaults
my $src_repo = '';
my $docker_repo = '';
my $image_name = '';
my $image_tag = '';
my $debug = 0;

GetOptions (
	"src_repo=s" => \$src_repo,
    "docker_repo=s"   => \$docker_repo,
	"image_name=s"  => \$image_name,
	"image_tag=s" => \$image_tag,
	"debug" => \$debug,
) or die("Error in command line arguments\n");

die qq(
usage: $0
	--src_repo        location to checkout the default files from (svn repo).
	--docker_repo     location to push the finial image.
	--image_name      docker name for the finial image.
	--image_tag       docker tag for the finial image.
	--debug           run in debug mode.
) unless $src_repo and $docker_repo and $image_name and $image_tag;

my $docker = SD::Docker->new(
	src_repo => $src_repo,
	docker_repo => $docker_repo,
	image_name => $image_name,
	image_tag => $image_tag,
	debug => $debug,
);

$docker->build_img;
$docker->push;
