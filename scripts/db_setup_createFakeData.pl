#!/usr/bin/perl

# use strict;
use warnings;

use Switch;
use DBI;
use Getopt::Long;
use Time::Local;
use Date::Manip;

#--------------------------------------------------------------------
# Check for requirements
#
# $VERIF_HOME must be set
my $HOME;
if ($ENV{'VERIF_HOME'}) {
	$HOME = $ENV{'VERIF_HOME'};
} else {
	print "[error] VERIF_HOME environment variable not set, please set it and rerun\n";
	exit;
}

#--------------------------------------------------------------------
# Get command line arguments
#
GetOptions ('datatype=s'	=> \$dataSettings{dataType},
			'help|h'		=> \$help
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($help) {
	printUsage();
}

#--------------------------------------------------------------------
# Check for required options
#
# Check for basic requirements
my @requiredArgs = ($dataSettings{dataType});
if (checkArgs(@requiredArgs)==0) { printUsage(); }

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Dimension of pseudo-grid
my $xDim = 36;
my $yDim = 19;
# Data settings
my $dataSettings;
if ($dataSettings{dataType} eq "forecast") {
	$dataSettings{header} = "STN   PRBB  PRBN  PRBA";
	$dataSettings{format} = "%4s  %01.2f  %01.2f  %01.2f";
} elsif ($dataSettings{dataType} eq "observation") {
	$dataSettings{header} = "STN   CAT";
	$dataSettings{format} = "%4s  %1d";
}

#--------------------------------------------------------------------
# Print header
#
print "$dataSettings{header}\n";

#--------------------------------------------------------------------
# Loop over dimensions of grid and generate fake data
#
for (my $x=1; $x<=$xDim; $x++) {
	for (my $y=1; $y<=$yDim; $y++) {
		my $id = sprintf("%02.0f%02.0f",$x,$y);
		if ($dataSettings{dataType} eq "forecast") {
			my $prob_below  = rand();
			my ($prob_normal, $prob_above);
			if ($prob_below > 0.66) {
				$prob_above = 1-$prob_below;
				$prob_normal = 0;
			} else {
				$prob_normal = 0.33;
				$prob_above = 1-($prob_below + $prob_normal);
			}
			printf("$dataSettings{format}\n",$id, $prob_below, $prob_normal, $prob_above);
		} elsif ($dataSettings{dataType} eq "observation") {
			my $cat = int(rand(3)) + 1;
			printf("$dataSettings{format}\n",$id, $cat);
		}
	}
}

sub printUsage {
	print "Usage: db_setup_createFakeData.pl [OPTIONS]

Required arguments:
  -datatype         Type of data being processed            forecast or observation
Optional arguments:
  -h, -help         Print this help message
";
	exit;
}
sub checkArgs {
	my $argsGood = 1;
	foreach $var (@_) {
		if (!defined($var)) {
			$argsGood = 0;
			last;
		}
	}
	return $argsGood;
}
