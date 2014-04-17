#!/usr/bin/perl

=head1 NAME

db_test_findMissing_batch - A Perl script to run db_test_findMissing for all possible combinations of arguments

=head1 SYNOPSIS

 db_test_findMissing_batch.pl [OPTIONS]

 Required arguments:
   -f, -fcsttype         Type of forecast (ERF, monthly, monthly_revised, seasonal)

 Optional arguments:
   -h, -help             print this help message
   -d, -daterange        date range to process - yyyymmdd-yyyymmdd (yyyymm-yyyymm) for ERF (monthly/monthly_revised/seasonal)
   -n, -dontcountnulls   If this option is used, then rows containing NULL values will
                         *not* count as missing. Since missing ASCII data files result
                         in NULL rows being inserted into the database when the import
                         script runs, this option will will reveal when the script 
                         itself hasn't run properly.
   -l, -loglevel         Sets the log4perl logging level (DEBUG, INFO, WARN,
                         ERROR, FATAL)
       -email            email any errors to the process owner

=head1 DESCRIPTION

This script is basically a driver script for L<db_test_findMissing.html>. It contains hardcoded calls to L<db_test_findMissing.html>. This script will look for missing observations and forecasts for the given forecast type.

=head1 REQUIRES

Getopt::Long, Pod::Usage, Date::Manip;

=head1 SEE ALSO

L<db_test_findMissing_batch.html>

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

use Pod::Usage;
use Getopt::Long;
use Date::Manip;
use Log::Log4perl;

#--------------------------------------------------------------------
# Get command line arguments
#
my %args;
GetOptions ('fcsttype|f=s'		=> \$args{fcstType},
			'daterange|d=s'		=> \$args{dateRange},
			'loglevel|l=s'		=> \$args{logLevel},
			'dontcountnulls|n'  => \$args{dontCountNullsOpt},
			'email'				=> \$args{emailOpt},
			'help|h'			=> \$args{help}
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($args{help}) {
	pod2usage();
}

# Convert log level to Upper Case
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}

#--------------------------------------------------------------------
# Validate arguments
#
checkArgs(%args);

#--------------------------------------------------------------------
# Set paths/properties
#
# Child script (which will be run in batch mode)
$childScript = "$HOME/scripts/db_test_findMissing.pl";

#--------------------------------------------------------------------
# Create list of options if any are set
#
my $options;
if ($args{logLevel})			{ $options = $options . " -loglevel $args{logLevel}"; }
if ($args{emailOpt})			{ $options = $options . " -email"; }
if ($args{dontCountNullsOpt})	{ $options = $options . " -dontcountnulls"; }

#--------------------------------------------------------------------
# Run child script - these are split by forecast type, since different
# forecast types are updated at different times, and shouldn't be
# labelled as "missing" if they haven't been updated yet.
#
# In the following sections, if dates were provided, use those. Otherwise set them
my $start_date, $end_date;
if (defined($args{dateRange})) {
	($start_date, $end_date) = split(/-/,$args{dateRange});
}
#-------------------- ERF --------------------#
if ($args{fcstType} eq "ERF") {
	unless (defined($start_date) and defined($end_date)) {
		$start_date = UnixDate("2 weeks ago",'%Y%m%d');
		$end_date   = UnixDate("4 days ago",'%Y%m%d');
	}
	system "$childScript $options -d observation -g stn      -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_05d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d observation -g grid2deg -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_05d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d forecast    -g stn      -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_05d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d forecast    -g grid2deg -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_05d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	$start_date = UnixDate("2 weeks ago",'%Y%m%d');
	$end_date   = UnixDate("5 days ago",'%Y%m%d');
	system "$childScript $options -d observation -g stn      -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_07d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d observation -g grid2deg -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_07d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d forecast    -g stn      -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_07d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
	system "$childScript $options -d forecast    -g grid2deg -s $start_date -e $end_date -f extendedRange -loglevel $args{logLevel} -tableinclude '_07d_' -tableexclude '.*([Bb]eta|Prob[0-9]+|ProbObs|cdc).*'";
}
#-------------------- monthly --------------------#
if ($args{fcstType} eq "monthly") {
	unless (defined($start_date) and defined($end_date)) {
		$start_date = UnixDate("1 years ago",'%Y%m');
		$end_date   = UnixDate("1 month ago",'%Y%m');
	}
	system "$childScript $options -d observation -g cd       -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_01m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d observation -g grid2deg -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_01m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d forecast    -g cd       -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_01m_01m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d forecast    -g grid2deg -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_01m_01m_[A-Za-z0-9]+\$'";
}
#-------------------- monthly_revised --------------------#
if ($args{fcstType} eq "monthly_revised") {
	unless (defined($start_date) and defined($end_date)) {
		$start_date = UnixDate("1 years ago",'%Y%m');
		$end_date   = UnixDate("1 month ago",'%Y%m');
	}
	system "$childScript $options -d forecast -g cd       -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_01m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d forecast -g grid2deg -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_0pt5m_01m_[A-Za-z0-9]+\$'";
}
#-------------------- seasonal --------------------#
if ($args{fcstType} eq "seasonal") {
	unless (defined($start_date) and defined($end_date)) {
		$start_date = UnixDate("1 years ago",'%Y%m');
		$end_date   = UnixDate("2 months ago",'%Y%m');
	}
	system "$childScript $options -d observation -g cd       -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_03m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d observation -g grid2deg -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_03m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d forecast    -g cd       -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_03m_[A-Za-z0-9]+\$'";
	system "$childScript $options -d forecast    -g grid2deg -s $start_date -e $end_date -f longRange -loglevel $args{logLevel} -tableinclude '_03m_[A-Za-z0-9]+\$'";
}

#--------------------------------------------------------------------
# Subroutines
#
sub checkArgs {
	# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	# Define an empty regex string for use below
	my $regex;

	#----------------------------------------------------------------
	# fcstType
	#
	$regex = 'ERF|monthly|monthly_revised|seasonal';
	unless (defined($args{fcstType}) and $args{fcstType} =~ m/\b($regex)\b/) { pod2usage("\nThe -fcsttype option is not set properly, was expecting: $regex\n"); }

	#----------------------------------------------------------------
	# dateRange
	#
	if (defined($args{dateRange})) {
		# Regex string depends on whether the day is required
		if ($args{fcstType} =~ m/ERF/) {
			$regex = '\d{8}-\d{8}';
		} elsif ($args{fcstType} =~ m/monthly|monthly_revised|seasonal/) {
			$regex = '\d{6}-\d{6}';
		}
		unless ($args{dateRange} =~ m/\b($regex)\b/) { pod2usage("\nThe -daterange option is not set properly, was expecting: $regex\n"); }
	}

	#----------------------------------------------------------------
	# logLevel
	#
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		$regex = 'TRACE|DEBUG|INFO|WARN|ERROR|FATAL';
		unless ($args{logLevel} =~ m/\b($regex)\b/) { pod2usage("\nThe -loglevel option is not set properly, was expecting: $regex\n"); }
	}
}
