#!/usr/bin/perl

my $HOME;
BEGIN {
    #--------------------------------------------------------------------
    # Check for VERIF_HOME environment variable
    #--------------------------------------------------------------------
    if ($ENV{'VERIF_HOME'}) {
        $HOME = $ENV{'VERIF_HOME'};
    } else {
        print "[error] VERIF_HOME environment variable not set, please set it and rerun\n";
        exit;
    }
}

use lib "$HOME/library/perl";
use Mysql;
use ConfigFile;

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Read in MySQL settings from a configuration file
my $configFile="$HOME/input/mysql.conf";
my %mysqlSettings = load_settings($configFile,"multi");
# Set the rest of the MySQL settings
$mysqlSettings{'database'} = 'reference';
$mysqlSettings{'table'} = "reference.grid2deg";
# Other
$maskFile = "../docs/maskedOut_grid2deg.txt";

#--------------------------------------------------------------------
# Connect to database
#
my $db = Mysql->connect($mysqlSettings{'host'},$mysqlSettings{'database'},$mysqlSettings{'user'},$mysqlSettings{'password'}) or die "Cannot connect to MySQL server: $!\n";

#--------------------------------------------------------------------
# Open text file containing masked out gridpoints
#
open(FILE, "<$maskFile");

#--------------------------------------------------------------------
# Loop over each line and remove that gridpoint from the reference table
#
while ($gridpoint = <FILE>) {
	chomp($gridpoint);
	$sqlQuery = "DELETE FROM $mysqlSettings{'table'} WHERE id=\"$gridpoint\"";
	print "$sqlQuery\n";
	$results = $db->query($sqlQuery);
}

#--------------------------------------------------------------------
# Close file
#
close(FILE);