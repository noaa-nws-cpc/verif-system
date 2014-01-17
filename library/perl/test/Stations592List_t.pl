#!/usr/bin/perl

use strict;
use warnings;
use lib '../';
use Stations592List;

my $list = Stations592List->new('/export/stsrv/aallgood/sandboxes/Verif_System/branches/DB_MonthlySeasonal/input/dig592list');

my @ids   = $list->SiteID;
my @names = $list->SiteName;
my $n     = 0;

while($ids[$n]) {
	print $n+1,".) ".$ids[$n]." is ".$names[$n]."\n";
	$n++;
}

