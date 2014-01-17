#!/usr/bin/perl

use Mysql;
use strict;
use warnings;

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# MySQL options
my %mysqlSettings;
$mysqlSettings{host}     = "lnx92.ncep.noaa.gov";
$mysqlSettings{user}     = "cpc";
$mysqlSettings{password} = "cpc";
$mysqlSettings{database} = "reference";
$mysqlSettings{table}    = "grid2deg";
# Dimension of pseudo-grid
my $xDim = 36;
my $yDim = 19;

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = Mysql->connect($mysqlSettings{'host'},$mysqlSettings{'database'},$mysqlSettings{'user'},$mysqlSettings{'password'}) or die "Cannot connect to MySQL server: $!\n";

#--------------------------------------------------------------------
# Make sure the table exists
#
unless (mysql_tableExists($db,$mysqlSettings{database},$mysqlSettings{table})) {
	print "Table $mysqlSettings{table} was not found in database $mysqlSettings{database}...\n";
	exit;
}

#--------------------------------------------------------------------
# Loop over dimensions of grid and insert a fake station for every
# grid point
#
for (my $x=1; $x<=$xDim; $x++) {
	for (my $y=1; $y<=$yDim; $y++) {
		my $id = sprintf("%02.0f%02.0f",$x,$y);
		my $sqlQuery = "INSERT INTO $mysqlSettings{table} (id, name, climateRegion, lat, lon) VALUES ('$id', '$id', 'NE', 0, 0)";
		$db->query($sqlQuery);
# 		print "$sqlQuery\n";
	}
}

sub mysql_tableExists {
	# Get input
	my $connection = $_[0];
	my $database   = $_[1];
	my $table      = $_[2];
	# If there's no DB connection, return
	unless ($connection) {
		print "No DB connection to determine table existance!\n";
		return 0;
	}
	# Create a query to retrieve the row corresponding to the requested table
	my $sqlQuery = "SHOW TABLES FROM $database LIKE '$table'";
	# See if a row was found
	my $results = $db->query($sqlQuery);
	if ($results->numrows() > 0) {
		return 1;
	} else {
		return 0;
	}
}
