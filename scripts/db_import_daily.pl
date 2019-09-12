#!/usr/bin/perl

=head1 NAME

db_import_daily - A Perl script to import ascii forecast and observation data into MySQL

=head1 SYNOPSIS

 db_import_daily.pl [OPTIONS]

 Required arguments:
   -f, -fcsttype         type of forecast (extendedRange, longRange)
   -s, -startdate        date to begin processing (yyyymmdd or yyyymm)
   -e, -enddate          date to begin end processing(yyyymmdd or yyyymm)
 Optional arguments:
   -h, -help             print this help message
   -validdate            assume dates are when the forecast is valid, not issued
   -noreplace            previous data will not be deleted over the given date range
   -destroy              delete the entire database table before importing
   -loglevel             Sets the log4perl logging level (DEBUG, INFO, WARN,ERROR, FATAL)
   -logfile              specifies a log file name, instead of printing to the screen
   -email                email any errors to the process owner

=head1 DESCRIPTION

This script is basically a driver script for L<db_import_data.html>. It accepts most of the
same optional arguments as L<db_import_data.html>, and then runs L<db_import_data.html> for all existing combinations of forecast variable, forecast source, lead time, etc.

=head1 REQUIRES

Getopt::Long, Pod::Usage

=head1 SEE ALSO

L<db_import_data.html>

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
use Pod::Usage;
use Log::Log4perl;
use Date::Manip;
#use Log::Dispatch::Email::MailSend;

GetOptions ('fcsttype|f=s'	=> \$args{fcstType},
			'startdate|s=s'	=> \$args{startDate},
			'enddate|e=s'	=> \$args{endDate},
			'noreplace'		=> \$args{noreplaceOpt},
			'destroy'		=> \$args{destroyOpt},
			'validdate'		=> \$args{validDateOpt},
			'loglevel=s'	=> \$args{logLevel},
			'logfile=s'		=> \$args{logFile},
			'email'			=> \$args{emailOpt},
			'help|h'		=> \${help}
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if (${help} or $argsMissing) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validateArgs(%args);

my $options = "";
if ($args{noreplaceOpt}) { $options = $options . " -noreplace";   }
if ($args{destroyOpt})   { $options = $options . " -destroy";   }
if ($args{validDateOpt}) { $options = $options . " -validdate"; }
if ($args{logLevel})     { $options = $options . " -loglevel $args{logLevel}";}
if ($args{logFile})      { $options = $options . " -logfile $args{logFile}";}

$importScript = "$HOME/scripts/db_import_data.pl";

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}
# Set up the logger configuration for just the file appender (if necessary)
my $loggerConfig;
if (defined($args{logFile})) {
	# Remove existing logfile
	if (defined($args{logFile})) { unlink $args{logFile};}
	# Define logger config string
	$loggerConfig = "
log4perl.rootLogger                             = $args{logLevel}, Screen, File
log4perl.appender.File                          = Log::Log4perl::Appender::File
log4perl.appender.File.filename                 = $args{logFile}
log4perl.appender.File.layout                   = Log::Log4perl::Layout::PatternLayout
log4perl.appender.File.layout.ConversionPattern = \%m\%n
log4perl.appender.File.Threshold                = $args{logLevel}
";
} else {
	$loggerConfig = "log4perl.rootLogger = $args{logLevel}, Screen";
}
# Set up the logger config string for any other appenders
$loggerConfig = $loggerConfig . "
log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
#log4perl.appender.Screen.layout.ConversionPattern = [\%d] ( \%C L\%L ) \%p - \%m\%n
log4perl.appender.Screen.layout.ConversionPattern  = \%m\%n
#log4perl.appender.Screen.Threshold                 = $args{logLevel}
#log4perl.category                = ERROR, Mailer
#log4perl.appender.Mailer         = Log::Dispatch::Email::MailSend
#log4perl.appender.Mailer.to      = \$mailSettings{processOwnerEmail}
#log4perl.appender.Mailer.subject = \$mailSettings{subject}
#log4perl.appender.Mailer.layout  = SimpleLayout
";
# Initialize the logger
Log::Log4perl::init( \$loggerConfig );
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Settings
#
# Email settings (for emailing a report)
#
# my %mailSettings;
# $mailSettings{processOwnerEmail} = "mike.charles\@noaa.gov"; # Use a '\' in front of the '@'
# $mailSettings{subject}           = "[Verification] Found missing data - $args{dataType} - $args{fcstType} - $args{spatialType}";
# $mailSettings{fromEmail}         = "cpc_VerifSystem\@noaa.gov";
# $mailSettings{fromName}          = "CPC VerifSystem";

#--------------------------------------------------------------------
# Forecasts
#
	if ($args{fcstType} eq "extendedRange") {
		#----------------------------------------------------------------
		# ERF
		#

		#------------------------------------------------------------
		# Station
		#
		# Manual
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d";
		# Auto
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource auto -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d";
		# Klein (prob)
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool kleins -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model ecens -cycle 00z";
		# analogss
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool analogs -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gfs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gfs -cycle 06z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle 06z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model ecm -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gfs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gfs -cycle 06z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle 06z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gfs -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gfs -cycle 06z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -cycle 06z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model ecm -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gfs -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gfs -cycle 06z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -cycle 06z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -cycle al";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model cmce -cycle 00z";
		# Calibrated (prob)
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool BC -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -cycle al";
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool BC";
		
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model naefs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model naefs -cycle 06z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model naefs -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model naefs -cycle 06z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model naefs -cycle 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model naefs -cycle 00z";
		# Uncalibrated (prob)
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool raw -skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model gefs -cycle al";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model ecens -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d -model cmce -cycle 00z";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d -model cmce -cycle 00z";
		# Reforecast-Calibrated Forecast
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool rfcstCal";
		system "$importScript $staticArgs -variable temp   -leadtime 08d -avewindow 05d -model gefs -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 11d -avewindow 07d -model gefs -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 08d -avewindow 05d -model ecens -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model ecens -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 11d -avewindow 07d -model ecens -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model ecens -c 00z";
		$staticArgs = "$options -spatialtype grid2deg -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource tool -tool rfcstCal";
		system "$importScript $staticArgs -variable temp   -leadtime 08d -avewindow 05d -model gefs -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model gefs -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 11d -avewindow 07d -model gefs -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model gefs -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 08d -avewindow 05d -model ecens -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d -model ecens -c 00z";
		system "$importScript $staticArgs -variable temp   -leadtime 11d -avewindow 07d -model ecens -c 00z";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d -model ecens -c 00z";
		# ERF Con
		$staticArgs = "$options -spatialtype stn -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource con";
		system "$importScript $staticArgs -variable temp    -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable temp    -leadtime 11d -avewindow 07d";
		system "$importScript $staticArgs -variable precip  -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable precip  -leadtime 11d -avewindow 07d";

		#------------------------------------------------------------
		# Gridded

		# Manual
		$staticArgs = "$options -spatialtype grid2deg -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable temp -leadtime 11d -avewindow 07d";
		system "$importScript $staticArgs -variable precip -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable precip -leadtime 11d -avewindow 07d";
		# ERF Con
		$staticArgs = "$options -spatialtype grid2deg -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource con";
		system "$importScript $staticArgs -variable temp    -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable temp    -leadtime 11d -avewindow 07d";
		system "$importScript $staticArgs -variable precip  -leadtime 08d -avewindow 05d";
		system "$importScript $staticArgs -variable precip  -leadtime 11d -avewindow 07d";
	} elsif ($args{fcstType} eq "longRange") {
	#----------------------------------------------------------------
	# LLF
	#

		#------------------------------------------------------------
		# Gridded
		#
		# Manual
		$staticArgs = "$options -spatialtype grid2deg -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable temp -leadtime 0pt5m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 0pt5m -avewindow 01m";
		$staticArgs = "$options -spatialtype grid2deg -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual --skip-header";
		runSeasonal($staticArgs, 2, 2); # Only lead 1 for now
		#------------------------------------------------------------
		# ClimateDivision
		#
		# Manual
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable temp -leadtime 0pt5m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 0pt5m -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource manual --skip-header";
		runSeasonal($staticArgs, 2, 14);
		# SMLR
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource smlr --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource smlr --skip-header";
		runSeasonal($staticArgs, 2, 14);
		# OCN
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource ocn --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource ocn --skip-header";
		runSeasonal($staticArgs, 2, 14);
		# CFS
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource cfs --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource cfs --skip-header";
		runSeasonal($staticArgs, 2, 14);
		# CCA
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource cca --skip-header";
		system "$importScript $staticArgs -variable temp -leadtime 01m -avewindow 01m";
		system "$importScript $staticArgs -variable precip -leadtime 01m -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -startdate $args{startDate} -enddate $args{endDate} -datatype forecast -fcstsource cca --skip-header";
		runSeasonal($staticArgs, 2, 14);
	}

#--------------------------------------------------------------------
# Observations
#
	if ($args{fcstType} eq "extendedRange") {
	#----------------------------------------------------------------
	# ERF
	#
		#------------------------------------------------------------
		# Station
		#
		$staticArgs = "$options -spatialtype stn -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
		system "$importScript $staticArgs -variable temp -avewindow 05d";
		system "$importScript $staticArgs -variable temp -avewindow 07d";
		system "$importScript $staticArgs -variable precip -avewindow 05d";
		system "$importScript $staticArgs -variable precip -avewindow 07d";
		#------------------------------------------------------------
		# Gridded
		#
		$staticArgs = "$options -spatialtype grid2deg -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
		system "$importScript $staticArgs -variable temp -avewindow 05d";
		system "$importScript $staticArgs -variable temp -avewindow 07d";
		system "$importScript $staticArgs -variable precip -avewindow 05d";
		system "$importScript $staticArgs -variable precip -avewindow 07d";
	} elsif ($args{fcstType} eq "longRange") {
	#----------------------------------------------------------------
	# LLF
	#
		#------------------------------------------------------------
		# Gridded
		#
		$staticArgs = "$options -spatialtype grid2deg -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
		system "$importScript $staticArgs -variable temp -avewindow 01m";
		system "$importScript $staticArgs -variable temp -avewindow 0pt5m";
		system "$importScript $staticArgs -variable precip -avewindow 01m";
		system "$importScript $staticArgs -variable precip -avewindow 0pt5m";
		$staticArgs = "$options -spatialtype grid2deg -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
		system "$importScript $staticArgs -variable precip -avewindow 03m";
		system "$importScript $staticArgs -variable temp -avewindow 03m";
		#------------------------------------------------------------
		# ClimateDivision
		#
		$staticArgs = "$options -spatialtype cd -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
 		system "$importScript $staticArgs -variable temp -avewindow 01m";
 		system "$importScript $staticArgs -variable precip -avewindow 01m";
		$staticArgs = "$options -spatialtype cd -datatype observation -startdate $args{startDate} -enddate $args{endDate} --skip-header";
		system "$importScript $staticArgs -variable temp -avewindow 03m";
		system "$importScript $staticArgs -variable precip -avewindow 03m";
	}

#====================================================================
#                           SUBROUTINES
#====================================================================

=head1 SUBROUTINES

=head2 runSeasonal()

Runs L<db_import_data.pl|db_import_data> over a given range of lead times for both
temperature and precipitation.

=cut
sub runSeasonal {
	my $staticArgs = $_[0];
	my $leadStart = $_[1];
	my $leadEnd = $_[2];
	for (my $lead=$leadStart; $lead<=$leadEnd; $lead++) {
		my $leadStr = sprintf('%02d',$lead);
		system "$importScript $staticArgs -variable temp -leadtime ${leadStr}m -avewindow 03m";
		system "$importScript $staticArgs -variable precip -leadtime ${leadStr}m -avewindow 03m";
	}
}


=head2 validateArgs()

Validates all input arguments. Nothing is returned, the subroutine simply validates each
against a regex string, and calls pod2usage() if an invalid argument was found. This will
print the usage and exit the program.

    Input
        args - Hash array of all input arguments

=cut
sub validateArgs {
	# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	# Define an empty regex string for use below
	my $regex;

	#--------------------------------------------------------------------
	# fcstType
	#--------------------------------------------------------------------
	$regex = 'extendedRange|longRange';
	unless (defined($args{fcstType}) and $args{fcstType} =~ m/\b($regex)\b/) { pod2usage("\nThe -fcstType option was not set properly. Must match the following regex: $regex\n"); }
	#--------------------------------------------------------------------
	# startDate
	#--------------------------------------------------------------------
	if ($args{fcstType} eq "extendedRange") {
		$regex = '\d{8}';
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option was not set properly. Must match the following regex: $regex\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		$regex = '\d{6}';
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option was not set properly. Must match the following regex: $regex\n"); }
	}
	#--------------------------------------------------------------------
	# endDate
	#--------------------------------------------------------------------
	if ($args{fcstType} eq "extendedRange") {
		$regex = '\d{8}';
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option was not set properly. Must match the following regex: $regex\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		$regex = '\d{6}';
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option was not set properly. Must match the following regex: $regex\n"); }
	}
	# Make sure endDate > startDate
	unless (compareDates($args{startDate},$args{endDate}) <= 0) { pod2usage("\nThe end date provided does not come after the start date provided\n"); }

	#--------------------------------------------------------------------
	# logLevel
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		$regex = 'TRACE|DEBUG|INFO|WARN|ERROR|FATAL';
		unless ($args{logLevel} =~ m/\b($regex)\b/i) { pod2usage("\nThe -loglevel option was not set properly. Must match the following regex: $regex\\n"); }
	}
}

=head2 compareDates()

Compares two dates to ensure the end date is greater than or equal to the start date.

    Input
        dateStr1 - First date in comparison
        dateStr2 - Second date in comparison
    Output
        A flag indicating the order of the two dates:
            <0 indicates that dateStr1 is earlier
            =0 indicates that the two dates are identical
            >0 indicates that dateStr2 is earlier

=cut
sub compareDates() {
    # Read in dates provided
    my $dateStr1 = $_[0];
    my $dateStr2 = $_[1];
    my $newDateStr1;
    my $newDateStr2;
    my $dateFormat;
    # Validate dates
    if ($dateStr1 =~ m/\b\d{8}\b/ and $dateStr2 =~ m/\b\d{8}\b/) {
        $newDateStr = substr($dateStr1, 0, 4) . "/" . substr($dateStr1, 4, 2) . "/" . substr($dateStr1, 6, 2);
    } elsif ($dateStr1 =~ m/\b\d{6}\b/ and $dateStr2 =~ m/\b\d{6}\b/) {
        $newDateStr = substr($dateStr1, 0, 4) . "/" . substr($dateStr1, 4, 2);
    } else {
        warn "compareDates() Cannot compare these two dates";
        return;
    }
    # Create new Date objects
    my $dateObj1 = ParseDate($newDateStr1);
    my $dateObj2 = ParseDate($newDateStr2);

    return Date_Cmp($dateObj1,$dateObj2);
}
