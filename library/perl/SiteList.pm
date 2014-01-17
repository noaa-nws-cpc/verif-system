#!/usr/bin/perl

package SiteList;

use strict;
use warnings;
use Carp;

# --------------- Begin POD Documentation ---------------

=pod

=head1 NAME


=head1 SYNOPSIS

 #!/usr/bin/perl
 ...

 use SiteList;

 ...

 my $datapoints = SiteList->new;
 $datapoints->SiteName(@pointnames);
 $datapoints->SiteID(@pointcodes);
 my $numpts = $datapoints->ListSize;

 foreach(my $i=0; $i<$numpts; $i++) {
 ...
 }

=head1 DESCRIPTION

Meteorological observations and CPC forecasts are valid for
discrete sets of spatial locations (e.g., "sites").  These sites
can be points (stations) or regions (climate divisions).  This
package provides a set of generic methods to define a set of
sites, identified by a unique name and a unique ID.  The size of
the list is set when the list of names or IDs are provided, and
the site list can optionally be given a name.  Inheritor classes
can bring more specificity to unique site lists.

=head1 CLASS METHODS

=head2 Constructor

=head3 new()

Returns a SiteList object with no defined values.  A SiteList object includes a hash reference
with the following items:

=over 4

=item * LISTTYPE - Scalar

=item * SITEID - Array

=item * SITENAME - Array

=item * SIZE - Scalar (integer)

=back

=head2 Object Data Access Methods

=head3 ListType

Returns LISTTYPE, setting it to $_[0] if provided.

=head3 SiteID

Returns SITEID, setting it to @_ if provided.  SIZE is set to scalar(@_).

=head3 SiteName

Returns SITENAME, setting it to @_ if provided.  SIZE is set to scalar(@_).

=head3 ListSize

Returns SIZE.

=head1 AUTHOR

Adam Allgood (Adam.Allgood@noaa.gov)

DOC/NOAA/NWS/NCEP/Climate Prediction Center

=cut

# ---------------  End POD Documentation  ---------------

# --------------- Constructor ---------------

sub new {
        my $class = shift;
        my $self  = {};

        $self->{LISTTYPE}  = undef;
        $self->{SITEID}    = [];
        $self->{SITENAME}  = [];
	$self->{SITEVALUE} = [];
        $self->{SIZE}      = undef;

        bless($self, $class);
        return($self);
}

# -------------------------------------------

# --------------- Object Data Access ---------------

sub ListType {
	my $self = shift;

	if(@_) {
		$self->{LISTTYPE} = shift;
		chomp($self->{LISTTYPE});
	}

	return $self->{LISTTYPE};
}

sub SiteID {
	my $self = shift;

	if(@_) {
		@{$self->{SITEID}} = @_;
		chomp(@{$self->{SITEID}});

                if(defined($self->{SIZE})) {
                        my $old = $self->{SIZE};
                        my $new = scalar(@{$self->{SITEID}});
                        carp "SiteID: Resetting list size from $old to $new to match input array" if($old != $new);
                }

		$self->{SIZE} = scalar(@{$self->{SITEID}});
	}

	return @{$self->{SITEID}};
}

sub SiteName {
        my $self = shift;

        if(@_) {
                @{$self->{SITENAME}} = @_;
                chomp(@{$self->{SITENAME}});

		if(defined($self->{SIZE})) {
			my $old = $self->{SIZE};
			my $new = scalar(@{$self->{SITENAME}});
			carp "SiteName: Resetting list size from $old to $new to match input array" if($old != $new);
		}

                $self->{SIZE} = scalar(@{$self->{SITENAME}});
        }

        return @{$self->{SITENAME}};
}

sub SiteValue {
	my $self = shift;

	if(@_) {
		@{$self->{SITEVALUE}} = @_;
		chomp(@{$self->{SITEVALUE}});
		carp "SiteValue: Warning!  No size for list has been set" if(not defined($self->{SIZE}));
	}

	return @{$self->{SITEVALUE}}
}

sub ListSize {
	my $self = shift;
	carp "ListSize: Size is undefined" if(not defined($self->{SIZE}));
	return $self->{SIZE};
}

# --------------------------------------------------

1;

