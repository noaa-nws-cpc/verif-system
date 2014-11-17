#!/usr/bin/perl

=head1 NAME

db_test_listTables - A Perl script to import ascii forecast and observation data into MySQL

=head1 SYNOPSIS

 db_test_printRows.pl [OPTIONS]

 Required options:
   -v, -variable         variable to process (temp or precip)
   -f, -fcstsource       data source (manual, auto, klein, etc.)
   -l, -leadtime         lead time with appended units (08d, 11d)
   -a, -avewindow        averaging window with appended units (05d, 07d)
   -g, -spatialtype      type of spatial data (cd, stn, grid2deg)
   -s, -startdate        date to begin processing (yyyymmdd)
   -e, -enddate          date to begin end processing(yyyymmdd)

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
use Pod::Usage;
use ConfigFile;

#--------------------------------------------------------------------
# Get command line arguments
#
GetOptions ('variable|v=s'		=> \$variable,
			'fcstsource|f=s'	=> \$source,
			'leadtime|l=s'		=> \$lead,
			'avewindow|a=s'		=> \$avewindow,
			'spatialtype|g=s'	=> \$spatialtype,
			'startdate|s=s'		=> \$startDate,
			'enddate|e=s'		=> \$endDate,
			'help|h'			=> \$help
);

#--------------------------------------------------------------------
# Check arguments
#
foreach $var ($variable, $source, $lead, $avewindow, $spatialtype, $startDate, $endDate) {
	if (!defined($var)) {
		$argsMissing = 1;
		last;
	}
}
# Determine if all arguments were provided
if ($help or $argsMissing) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Set options
#
# Read in MySQL settings from a configuration file
my $configFile="$HOME/input/verif_data.conf";
my %mysqlSettings = load_settings($configFile,"multi");
print "$mysqlSettings{host}\n";
# Set the rest of the MySQL settings
$mysqlSettings{'database'} = 'forecasts';
$mysqlSettings{'table'} = "${variable}_${source}_${lead}_${avewindow}_${spatialtype}";

#--------------------------------------------------------------------
# Print diagnostic information
#
print "--------------------------------------------------------------------

- MySQL info -

  Host:     $mysqlSettings{'host'}
  User:     $mysqlSettings{'user'}
  Database: $mysqlSettings{'database'}
  Table:    $mysqlSettings{'table'}

- Making MySQL connection -

";

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = DBI->connect("DBI:mysql:$mysqlSettings{database};host=$mysqlSettings{host}",$mysqlSettings{user},$mysqlSettings{password});
print "  Successfully connected to database...\n";
# If the table doesn't exist, exit the script
$sqlQuery = "SHOW TABLES LIKE '$mysqlSettings{'table'}'";
my $results = $db->prepare($sqlQuery) ; $results->execute();
if ($results->rows > 0) {
	print "  Table '$mysqlSettings{'table'}' exists...\n";
} else {
	print "  Table '$mysqlSettings{'table'}' does not exist, exiting...\n";
	exit;
}
print "\n";
#--------------------------------------------------------------------
# Convert user-given start/end dates into machine dates
#
# Get machine dates
$sdate1 = date_str2mach($startDate);
$sdate2 = date_str2mach($endDate);
# Time interval, in seconds, between files
$dateInt = 86400; # 1 day

#--------------------------------------------------------------------
# Loop over all dates
#
for ($date=$sdate1; $date<=$sdate2; $date=$date+$dateInt) {
	#--------------------------------------------------------------------
	# Get date in string format
	#
	$dateStr = date_mach2str($date) . "\n";
	chomp($dateStr); # Remove trailing return character
	($yyyy, $mm, $dd) = date_strParse($dateStr);
	# Date is part of the input filename
	$inputFilenamePiece[2] = $dateStr;

	# Print how many rows now exist
	$sqlDate = date_str2mysql(date_mach2str($date));
	$sqlQuery = "select * from reference.stations JOIN $mysqlSettings{'table'} using(id) where date_issued='$sqlDate'";
	$results = $db->prepare($sqlQuery) ; $results->execute();
	$numRows = $results->rows;
	print "$sqlDate: Found $numRows rows...\n";
}

#####################################################################
# Subroutines
#
sub date_str2mysql {
	my $date = $_[0];
	($y, $m, $d) = date_strParse($date);
	return "$y-$m-$d";
}
sub date_str2mach {
	my $date = $_[0];
	($y, $m, $d) = date_strParse($date);
	return timegm(0,0,0,$d,$m-1,$y-1900)
}
sub date_mach2str {
	my $date = $_[0];
	my $j, $y, $m, $d;
	($j,$j,$j,$d,$m,$y) = gmtime($date);
	$m = $m+1 ;
	$y = $y+1900;
	return sprintf('%4d%02d%02d',$y,$m,$d);
}
sub date_strParse {
	my $date = $_[0];
	my $y = substr($date,0,4) ;
	my $m = substr($date,4,2) ;
	my $d = substr($date,6,2) ;
	return ($y, $m, $d);
}
