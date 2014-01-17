#!/usr/bin/perl

package Month;

use strict;
use warnings;
use Carp;
use overload
	'+'  => \&MonthAdd,
	'-'  => \&MonthSubtract,
	'""' => \&MonthStringify,
	'>'  => \&MonthGreaterThan,
	'<'  => \&MonthLessThan,
	'==' => \&MonthSameAs,
	'>=' => \&MonthGreaterThanOrEqualTo,
	'<=' => \&MonthLessThanOrEqualTo;


# --------------- POD Package Documentation ---------------

=pod

=head1 NAME

Month - Perl class for calendar processing of months

=head1 SYNOPSIS

 #!/usr/bin/perl;
 
 use strict;
 use warnings;
 use lib '/.../.../...';
 use Month;
 
 # Print out information for every month in the year 2000!
 
 my $month = Month->new(1, 2000);
 
 for(my $i=0; $i<12; $i++) {
         $month->PrintObject;
         $month++;
 }
 
 # Get information about the current month!
 
 my $currentMonth = Month->new();
 $currentMonth->PrintObject;
 
 # Compare another month relative to the current month!

 my $sixMonthsAgo = $currentMonth -6;
 my $numMonths    = $currentMonth - $sixMonthsAgo;
 my $monthName    = $sixMonthsAgo->Name;
 print "$monthName was $numMonths months ago.\n";

=head1 DESCRIPTION

Month is an object-oriented Perl class (package) that is used to generate Month objects.  A month
object constructed in your program provides the following information about a unique month on the
Gregorian Calendar:

=over 4

=item * Name of the month (e.g., January)

=item * Month number (e.g, 1)

=item * Number of days in the month (e.g., 31)

=item * The year that the month falls into (e.g., 2010)

=back

The Month class can construct a month object either reflecting the current month indicated by the
machine's system clock or a month specified by the user.  The class also has methods overloading
the addition ('+') and subtraction ('-') operators, which can be used to return new month objects
relative to existing ones.

=head1 CLASS METHODS

=head2 Constructor

=head3 new

Usage:

 my $currentMonth = Month->new();
 my $Feb2008      = Month->new(2, 2008);

The constructor C<new> returns an object from the Month class set to a unique month.  If no
arguments are supplied, C<new> returns the current month based on the system clock, using Perl's
built in function C<localtime>.  When supplied two integer arguments, a month number (e.g., 1 for
January, 2 for February, etc.) followed by an integer year, C<new> returns a Month object based
on the supplied month.

=head2 Object Data Access Methods

The following methods return object data to the calling program:

=head3 Length

Usage:

 my $currentMonth   = Month->new();
 my $numDaysInMonth = $currentMonth->Length;

Returns the number of days in the month described by the Month object.

=head3 Name

Usage:

 my $currentMonth   = Month->new();
 my $monthName      = $currentMonth->Name;

Returns the name of the month described by the Month object (e.g., "January").

=head3 Number

Usage:

 my $currentMonth   = Month->new();
 my $monthNumber    = $currentMonth->Number;

Returns the number in which the month described by the Month object appears during the year (e.g., 1 for January, 12 for December).

=head3 Year

Usage:

 my $currentMonth   = Month->new();
 my $numDaysInMonth = $currentMonth->Year;

Returns the year in which the month described by the Month object falls.

=head3 PrintObject

Usage:

 my $currentMonth  = Month->new();
 $currentMonth->PrintObject;

Does not return a value to the calling program.  C<PrintObject> labels and prints the four scalar values available in the Month object to STDOUT.
This method is useful for debugging purposes.

=head2 Operator Overloading Methods

=head3 MonthAdd

Usage:

 my $currentMonth  = Month->new();
 my $nextMonth     = $currentMonth++;
 my $nextNextMonth = $currentMonth + 2;

C<MonthAdd> overloads Perl's '+' operator to supply functionality with Month objects.  C<MonthAdd> only permits the '+' operation between a single
Month object and an integer (can be positive or negative).  The new functionality of '+' returns a new Month object advanced (or backtracked) by the
number of months defined by the integer argument relative to the Month object argument.  For example:

 my $month1  = Month->new(1, 2010);
 my $month2  = $month1 + 6;        # This will return a Month->new(7, 2010)

=head3 MonthSubtract

Usage:

 my $currentMonth  = Month->new();
 my $previousMonth = $currentMonth--;
 my $numMonthsBack = $currentMonth - $previousMonth;

C<MonthSubtract> overloads Perl's '-' operator to supply functionality with Month objects.  C<MonthSubtract> permits the '-' operation with
a Month object on the left side and an integer on the right side (can be positive or negative), returning a new Month object backtracked
(or advanced) by the number of months defined by the integer argument relative to the Month object argument.  Additionally, C<MonthSubtract>
permits the '-' operation between two Month objects, returning an integer defining the number of months between the two arguments.  Subtracting
a Month object from another Month object that falls "later" yields a positive result.  For example:

 my $month1  = Month->new(1, 2010);
 my $month2  = $month1 - 1;         # This will return a Month->new(12, 2009)
 my $integer = $month1 - $month2;   # This will return 1.

=head3 MonthStringify

C<MonthStringify> overloads Perl's '""' operator to supply functionality with Month objects.  If a user attempts to convert a Month object
to a string, then C<MonthStringify> will return a string of the format "MonthYYYY", where Month is the name of the month (e.g., January) and
YYYY is the integer year.

=head3 MonthGreaterThan

=head3 MonthLessThan

=head3 MonthSameAs

=head3 MonthGreaterThanOrEqualTo

=head3 MonthLessThanOrEqualTo

=head1 SEE ALSO

=over 4

=item * Operator Overloading in Perl: L<http://perldoc.perl.org/overload>

=item * Perl Object-Oriented Programming Tutorial: L<http://perldoc.perl.org/perltoot>

=back

=head1 AUTHOR

Adam Allgood (Adam.Allgood@noaa.gov)

Climate Prediction Center - DOC/NOAA/NWS/NCEP

=cut

# ---------------   End POD Documentation   ---------------

# --------------- Package Data ---------------

my @monthName   = ("January", "February", "March", "April", "May", "June", "July",
                   "August", "September", "October", "November", "December");
my @monthLength = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

# --------------------------------------------

# --------------- Constructor ---------------

sub new {
	my $class = shift;
	my $self  = {};
	my $mnum;
	my $year;

	if(not @_) {
		my @timeData = localtime(time);
		$mnum        = $timeData[4];  $mnum++;
		$year        = $timeData[5];  $year += 1900;
	}
	elsif(@_ >= 2) {
		$mnum = $_[0];
		$year = $_[1];

		if(not $year =~ /^[+-]?\d+$/ or not $mnum =~ /^[+-]?\d+$/) {
			croak "Noninteger argument(s) passed to Month->new() contructor";
		}

		if($year == 0) {
			croak "Cannot construct Month object for year 0";
		}

		if($mnum < 1 or $mnum > 12) {
			croak "Invalid month number argument passed to Month->new() constructor";
		}

	}
	else {
		croak "Invalid argument(s) passed to Month->() constructor";
	}

	$self->{NAME}   = $monthName[$mnum - 1];
	$self->{NUMBER} = $mnum;
	$self->{YEAR}   = $year;

	# Determine $self->{LENGTH} based on leap year considerations!

	if($mnum == 2) {

		if(($year % 4) == 0 and ($year % 100) != 0 or ($year % 400) == 0) {
			$self->{LENGTH} = $monthLength[$mnum - 1] + 1;
		}
		else {
			$self->{LENGTH} = $monthLength[$mnum - 1];
		}

	}
	else {
		$self->{LENGTH} = $monthLength[$mnum - 1];
	}

	bless($self, $class);
	return($self);
}

# -------------------------------------------

# --------------- Object Data Access Methods---------------

sub Length {
	my $self = shift;
	return $self->{LENGTH};
}

sub Name {
	my $self = shift;
	return $self->{NAME};
}

sub Number {
	my $self = shift;
	return $self->{NUMBER};
}

sub Year {
	my $self = shift;
	return $self->{YEAR};
}

sub PrintObject {
	my $self = shift;
	print "\n", ref $self," Object Data:\n";
	print "---------------\n";
	print "Month Length: ", $self->{LENGTH}, "\n";
	print "Month Name:   ", $self->{NAME}, "\n";
	print "Month Number: ", $self->{NUMBER}, "\n";
	print "Month Year:   ", $self->{YEAR}, "\n\n";
}

# ---------------------------------------------------------

# --------------- Operator Overloading Methods ---------------

sub MonthAdd {
	my($monthObj, $addend) = @_;
	my $mnum = $monthObj->Number;
	my $year = $monthObj->Year;

	if(ref $addend) {
		croak "Cannot add a ", ref $addend, " to a ", ref $monthObj;
	}

	if(not $addend =~ /^[+-]?\d+$/) {
		croak "Cannot add $addend to a ", ref $monthObj;
	}

	if($addend >= 0) {

		for(my $i=0; $i<$addend; $i++) {
			$mnum++;
			if($mnum == 13) { $mnum = 1; $year++; }
		}

	}
	else {

		for(my $i=0; $i>$addend; $i--) {
			$mnum--;
			if($mnum == 0) { $mnum = 12; $year--; }
		}

	}

	return Month->new($mnum, $year);
}

sub MonthSubtract {
	my($monthObj, $term, $switch) = @_;
	my $mnum = $monthObj->Number;
	my $year = $monthObj->Year;

	if(ref $term) {

		if(UNIVERSAL::isa($term, ref $monthObj)) {
			my $termMnum = $term->Number;
			my $termYear = $term->Year;

			if(not $switch) {
				return (12*($year - $termYear) + $mnum - $termMnum);
			}
			else {
         			return (12*($termYear - $year) + $termMnum - $mnum);
			}
		}
		else {
			croak "Cannot subtract a ", ref $term, " from a ", ref $monthObj;
		}
	}

	if(not $term =~ /^[+-]?\d+$/) {
		croak "Cannot subtract $term and a ", ref $monthObj;
	}

	if($switch) {
		croak "The ", ref $monthObj, " cannot be on the right side of the equation";
	}

	if($term >= 0) {

               	for(my $i=0; $i<$term; $i++) {
                       	$mnum--;
                       	if($mnum == 0) { $mnum = 12; $year--; }
               	}

       	}
       	else {

               	for(my $i=0; $i>$term; $i--) {
                       	$mnum++;
                       	if($mnum == 13) { $mnum = 1; $year++; }
               	}

       	}

	return Month->new($mnum, $year);
}

sub MonthStringify {
	my $self = shift;
	my $name = $self->Name;
	my $year = $self->Year;
	return $name.$year;
}

sub MonthGreaterThan { # This overloads >
	my($a, $b, $switched) = @_;

	if(not UNIVERSAL::isa($b, ref $a)) {
		croak "A Month object cannot be compared to $b";
	}

	my $aYr = $a->Year;
	my $bYr = $b->Year;
	my $aMo = $a->Number;
	my $bMo = $b->Number;

	# Express the months numerically!
	my $aNum = 100*$aYr + $aMo;
	my $bNum = 100*$bYr + $bMo;

	if($switched) { return($bNum > $aNum); }
	else { return($aNum > $bNum); }

}

sub MonthLessThan { # This overloads <
        my($a, $b, $switched) = @_;

        if(not UNIVERSAL::isa($b, ref $a)) {
                croak "A Month object cannot be compared to $b";
        }

        my $aYr = $a->Year;
        my $bYr = $b->Year;
        my $aMo = $a->Number;
        my $bMo = $b->Number;

        # Express the months numerically!
        my $aNum = 100*$aYr + $aMo;
        my $bNum = 100*$bYr + $bMo;

        if($switched) { return($bNum < $aNum); }
        else { return($aNum < $bNum); }

}

sub MonthSameAs { # This overloads ==
        my($a, $b) = @_;

        if(not UNIVERSAL::isa($b, ref $a)) {
                return 0; # False!!
        }

        my $aYr = $a->Year;
        my $bYr = $b->Year;
        my $aMo = $a->Number;
        my $bMo = $b->Number;

        # Express the months numerically!
        my $aNum = 100*$aYr + $aMo;
        my $bNum = 100*$bYr + $bMo;

        return($bNum == $aNum);

}

sub MonthGreaterThanOrEqualTo { # This overloads >=
        my($a, $b, $switched) = @_;

        if(not UNIVERSAL::isa($b, ref $a)) {
                croak "A Month object cannot be compared to $b";
        }

        my $aYr = $a->Year;
        my $bYr = $b->Year;
        my $aMo = $a->Number;
        my $bMo = $b->Number;

        # Express the months numerically!
        my $aNum = 100*$aYr + $aMo;
        my $bNum = 100*$bYr + $bMo;

        if($switched) { return($bNum >= $aNum); }
        else { return($aNum >= $bNum); }

}

sub MonthLessThanOrEqualTo { # This overloads <=
        my($a, $b, $switched) = @_;

        if(not UNIVERSAL::isa($b, ref $a)) {
                croak "A Month object cannot be compared to $b";
        }

        my $aYr = $a->Year;
        my $bYr = $b->Year;
        my $aMo = $a->Number;
        my $bMo = $b->Number;

        # Express the months numerically!
        my $aNum = 100*$aYr + $aMo;
        my $bNum = 100*$bYr + $bMo;

        if($switched) { return($bNum <= $aNum); }
        else { return($aNum <= $bNum); }

}

# ------------------------------------------------------------
1;

