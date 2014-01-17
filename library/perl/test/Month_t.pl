#!/usr/bin/perl

use strict;
use warnings;
use lib '../';
use Month;

my $mon1 = Month->new();  # this month.
my $mon2 = $mon1 + 5;     # 5 months down the road.
print "\n";

for(my $m=$mon1; $m<=$mon2; $m++) {
	print "$m\n";
}

print "Done!!!\n";

