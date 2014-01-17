#!/usr/bin/perl

package ForecastDivisionList;

use strict;
use warnings;
use Carp;
use SiteList;
use Stations592List;

our @ISA = qw(SiteList); # SiteList is now a superclass of ForecastDivisionList.

# --------------- Begin POD Documentation ---------------

# ---------------  End POD Documentation  ---------------

sub new {
	my $class = shift;
	my $self  = $class->SUPER::new();

	# Arg is abs path to dir where csv text file holding list of FDs AND weights. Open csv...
	my $defsDir = shift;
	chomp $defsDir;
	my $endChar = substr($defsDir,-1);
	if($endChar eq '/') { $defsDir = substr($defsDir, 0, -1); }  # Pop off trailing / if there.
	my $defsFile = $defsDir."/ForecastDivisions102.txt";
	croak "Could not find Forecast Divisions defs file $defsFile" if(not -s $defsFile);
	open(DEFS, '<', $defsFile) or croak $!;
	my @defsFileContent = <DEFS>;
	chomp @defsFileContent;
	my(@id, @name);

	foreach my $line (@defsFileContent) {
		my($id, $name) = split(',', $line, 2);
		# Kill the ""'s if found!
		$name =~ s/\"//g;
		push(@id, $id);
		push(@name, $name);
	}

	$self->SiteID(@id);
	$self->SiteName(@name);
	$self->{DEFSDIR} = $defsDir;

	bless($self, $class);
	return $self;
}

sub SiteValue {
	my $self = shift;
	my $ref;

	if(@_) {
		$ref = $_[0];
#		my $statest = Stations592List->new;
		my @stnVals;

		if(UNIVERSAL::isa($ref, 'Stations592List')) {
			# 1.) Check $ref for values

			if(not defined($ref->SiteValue)) {
				carp "Stations592List argument has no data to convert to forecast divisions";
				return undef;
			}
			else { @stnVals = $ref->SiteValue; }

			# 2.) Open weights file
			my $wtsFile = $self->{DEFSDIR}."/wtstn592";
			croak "Could not find weights file $wtsFile to set SiteValue" if(not -s $wtsFile);
			open(WTS, '<', $wtsFile) or croak $!;
			my @wtsFileContent = <WTS>;
			chomp @wtsFileContent;

			# 3.) Parse weights file line by line, calculating FD value via weights.
			my @fdVals;

			foreach my $line (@wtsFileContent) {
				my($fd, $stn1, $stn2, $stn3, $stn4, $wt1, $wt2, $wt3, $wt4) = split(' ', $line);
				my $val = $wt1*$stnVals[$stn1-1] + $wt2*$stnVals[$stn2-1] + $wt3*$stnVals[$stn3-1] + $wt4*$stnVals[$stn4-1];
				push(@fdVals, $val);
			}

			if(not defined($self->ListSize)) { carp "Warning!  Proper list size was not defined"; }
			elsif(not scalar(@fdVals) == $self->ListSize) { croak "Could not properly set SiteValue"; }
			else {
				@{$self->{SITEVALUE}} = @fdVals;
			}
		}
		else {
			@{$self->{SITEVALUE}} = @_;
			chomp(@{$self->{SITEVALUE}});
			carp "Warning!  No list size has been set" if(not defined($self->{SIZE}));
		}
	}

	return @{$self->{SITEVALUE}};
}

# ---------------
1;

