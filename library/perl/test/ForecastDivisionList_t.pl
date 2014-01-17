#!/usr/bin/perl

use strict;
use warnings;
use lib '../';
use ForecastDivisionList;
use Stations592List;

my $list = ForecastDivisionList->new('/export/stsrv/aallgood/sandboxes/Verif_System/branches/DB_MonthlySeasonal/input/');

my @ids   = $list->SiteID;
my @names = $list->SiteName;
my $n     = 0;

#while($ids[$n]) {
#	print $n+1,".) ".$ids[$n]." is ".$names[$n]."\n";
#	$n++;
#}

my @testData;

while($n<592) {
	push(@testData, 5.0);
	$n++;
}

my $stations = Stations592List->new('/export/stsrv/aallgood/sandboxes/Verif_System/branches/DB_MonthlySeasonal/input/dig592list');
$stations->SiteValue(@testData);

my @fdData = $list->SiteValue($stations);

$n = 0;

while($ids[$n]) {
	print $n+1,".) ".$ids[$n]." has a value of ".$fdData[$n]."\n";
	$n++;
}

