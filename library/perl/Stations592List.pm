#!/usr/bin/perl

package Stations592List;

use strict;
use warnings;
use Carp;
use SiteList;

our @ISA = qw(SiteList); # SiteList is now a superclass of Stations592List.

# --------------- Begin POD Documentation ---------------

# ---------------  End POD Documentation  ---------------

sub new {
	my $class = shift;
	my $self  = $class->SUPER::new();

        # Arg is abs path to text file holding list of stations.  Open it.
        my $defsFile = shift;
        chomp $defsFile;
        croak "Could not find 592 Stations defs file $defsFile" if(not -s $defsFile);
        open(DEFS, '<', $defsFile) or croak $!;
        my @defsFileContent = <DEFS>;
        chomp @defsFileContent;
	shift @defsFileContent;  # Remove header line.
        my(@id, @name);

	foreach my $line (@defsFileContent) {
		my @lineVals = split(" ", $line);
		croak "Did not read the defs file correctly" if((scalar(@lineVals) % 2) != 0);
		my $n = 0;

		while($lineVals[$n]) {
			my $id   = $lineVals[$n]; $n++;
			my $name = $lineVals[$n]; $n++;
			push(@id, int($id));
			push(@name, int($name));
		}
	}

        $self->SiteID(@id);
        $self->SiteName(@name);

        bless($self, $class);
        return $self;
}

# ---------------
1;

