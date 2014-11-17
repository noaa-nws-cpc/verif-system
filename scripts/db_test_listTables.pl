#!/usr/bin/perl

=head1 NAME

db_test_listTables - A Perl script to import ascii forecast and observation data into MySQL

=head1 SYNOPSIS

 db_test_listTables.pl [OPTIONS]

 Required arguments:
   -d, -database     Database to list tables from          forecasts or observations
 Optional arguments:
   -h, -help         Print this help message

=head1 DESCRIPTION

This script lists all tables from a given database.

=head1 SEE ALSO



=cut

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
use Getopt::Long;
use Switch;
use DBI;
use Time::Local;
use Date::Manip;
use Pod::Usage;
use ConfigFile;

#--------------------------------------------------------------------
# Get command line arguments
#
GetOptions ('database|d=s'	=> \$database,
			'help|h'		=> \$help
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($help) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Check for required options
#
# Check for basic requirements
my @requiredArgs = ($database);
if (checkArgs(@requiredArgs)==0) { printUsage(); }

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Read in settings from a configuration file
my $configFile="$HOME/input/verif_data.conf";
my %settings = load_settings($configFile,"multi");
# Extract only the MySQL settings
my %mysqlSettings = %{$settings{mysql}};
# Set the rest of the MySQL settings
$mysqlSettings{'database'} = $database;

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = DBI->connect("DBI:mysql:$mysqlSettings{database};host=$mysqlSettings{host}",$mysqlSettings{user},$mysqlSettings{password}); 

#--------------------------------------------------------------------
# List all tables in this database
#
$sqlQuery = "SHOW TABLES FROM  $mysqlSettings{database}";
# Execuate the SQL query
my $results = $db->prepare($sqlQuery) ; $results->execute(); 
# Loop over each table and print out
while (my $table = $results->fetchrow_array) {
	print "$table\n";
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

sub printUsage {
	print "Usage: db_test_listTables.pl [OPTIONS]

Required arguments:
  -database         Database to list tables from

Optional arguments:
  -h, -help         Print this help message
";
	exit;
}
