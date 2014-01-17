#!/usr/bin/perl

=head1 NAME

db_setup_sync.pl - A Perl script to find missing forecast and/or obs data in the database

=head1 SYNOPSIS

 db_setup_sync.pl [OPTIONS]

 Required arguments:
   -c, -config_file       File containing configuration options

 Optional arguments:
   -h, -help             print this help message
       -email            email any errors to the process owner
   -l, -loglevel         Sets the log4perl logging level (DEBUG - least important, INFO,
                         WARN, ERROR, FATAL - most important ). Setting a threshold means
                         you'll see messages of that importance level, plus all higher levels:
                             DEBUG: shows very detailed information (like SQL queries)
                             INFO:  shows general information
                             WARN:  shows days missing a small percentage of values
                             ERROR: shows days missing a large percentage of values
                             FATAL: shows problems executing the script itself

=head1 DESCRIPTION



=head1 REQUIRES

Pod::Usage, Getopt::Long, Log::Log4perl, Pod::Usage

=head1 SEE ALSO


=cut

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
# Hide warnings from 'eval'
	$SIG{__WARN__} = sub {};
}

# Import required packages
use lib "$HOME/library/perl";
use Getopt::Long;
use ConfigFile;
use Pod::Usage;
use Log::Log4perl;
use Date::Manip;
use warnings;
use strict;

#--------------------------------------------------------------------
# Get command line arguments
#--------------------------------------------------------------------
my (%args,$help);
GetOptions ('config_file|c=s'	=> \$args{config_file},
			'loglevel=s'		=> \$args{log_level},
			'email'				=> \$args{email_opt},
			'help|h'			=> \$help
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#--------------------------------------------------------------------
if ($help) {
	pod2usage(1);
}

# Convert log level to Upper Case
if ($args{log_level}) {
# Convert the given log level to ALL CAPS
	$args{log_level} = uc($args{log_level});
} else {
# Default to INFO
	$args{log_level} = "INFO";
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validate_args(%args);

#--------------------------------------------------------------------
# Additional settings
#--------------------------------------------------------------------
my $db_backup_filename = "mysqldump.sql.gz";

#--------------------------------------------------------------------
# Get the current date/time
#--------------------------------------------------------------------
my $current_time = &UnixDate("today",'%T %Z %Y-%m-%d');

#--------------------------------------------------------------------
# Read in settings from a configuration file
#--------------------------------------------------------------------
# Use load_settings() to load the settings
my $config_file="$args{config_file}";
my %settings = load_settings($config_file,"multi");
# Extract separate settings sections
my %source      = %{$settings{source}};
my %destination = %{$settings{destination}};
my %email       = %{$settings{email}};
# Create an email subject if necessary
unless ($email{subject}) {
	$email{subject} = "Database sync error ($source{db_host} -> $destination{db_host})";
}

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
if ($args{log_level}) {
# Convert the given log level to ALL CAPS
	$args{log_level} = uc($args{log_level});
} else {
# Default to INFO
	$args{log_level} = "INFO";
}
# Set up the default configuration
my %logger_config = (
	'log4perl.rootLogger'								=> "DEBUG, Screen",
	'log4perl.appender.Screen'							=> "Log::Log4perl::Appender::Screen",
	'log4perl.appender.Screen.layout'					=> "Log::Log4perl::Layout::PatternLayout",
	'log4perl.appender.Screen.layout.ConversionPattern'	=> "\%m\%n",
	'log4perl.appender.Screen.Threshold'				=> "$args{log_level}"
);
# If the email option is turned on
if (defined($args{email_opt})) {
	# Add "Mailer" to the root logger
	$logger_config{'log4perl.rootLogger'} .= ", Mailer";
	# Add a Mailer appender (will send out email when an ERROR-level log call occurs)
	%logger_config = (%logger_config, (
	'log4perl.appender.Mailer'							=> "Log::Dispatch::Email::MailSend",
	'log4perl.appender.Mailer.to'						=> "$email{to_email}",
	'log4perl.appender.Mailer.from'						=> "\"$email{from_name}\" <$email{from_email}>",
	'log4perl.appender.Mailer.subject'					=> "$email{subject}",
	'log4perl.appender.Mailer.layout'					=> "Log::Log4perl::Layout::PatternLayout",
	'log4perl.appender.Mailer.layout.ConversionPattern'	=> "\%m\%n",
	'log4perl.appender.Mailer.Threshold'				=> "$email{log_level}"
	));
}
# Initialize the logger
Log::Log4perl::init( \%logger_config );
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Create list of options if any are set
#--------------------------------------------------------------------
my $options_set;
if ($args{log_level})        { $options_set .= "  -loglevel      $args{log_level}\n"; }
if ($args{email_opt})        { $options_set .= "  -email\n"; }

#--------------------------------------------------------------------
# Print settings and information
#--------------------------------------------------------------------
# Create a welcome message
my $welcome_message = "
-----------------------------------------------------------
|                 Database Syncing Utility                |
-----------------------------------------------------------

 Program started at $current_time

- Settings -

  Config file:      $args{config_file}

";
# Add optional args if necessary
if ($options_set) { $welcome_message .= "- Options set -\n\n$options_set"; }
# Print the welcome message
$logger->info($welcome_message);
# Start the main program
$logger->info("\n- Main program -\n\n");

my $command;

#--------------------------------------------------------------------
# Remove the existing backup file
#--------------------------------------------------------------------
$command = "rm -f $db_backup_filename";
$logger->info("  Removing the existing back file ($db_backup_filename)...");
$logger->debug("    $command");
system "$command";

#--------------------------------------------------------------------
# Backup the source database
#--------------------------------------------------------------------
$command = "ssh -q $source{ssh_user}\@$source{ssh_server} mysqldump -h $source{db_host} -u $source{db_user} --password=$source{db_password} --databases $source{db_list} | gzip > $db_backup_filename";
$logger->info("  Backing up the source database...");
$logger->debug("    $command");
system "$command";

#--------------------------------------------------------------------
# Send the database backup to the destination server
#--------------------------------------------------------------------
$command ="scp $db_backup_filename $destination{ssh_user}\@$destination{ssh_server}:~";
$logger->info("  Copying the database backup to the destination server...");
$logger->debug("    $command");
system "$command";

#--------------------------------------------------------------------
# Restore the backup to the destination database
#--------------------------------------------------------------------
$command = "ssh -q $destination{ssh_user}\@$destination{ssh_server} \"gunzip < $db_backup_filename | mysql -h $destination{db_host} -u $destination{db_user} --password=$destination{db_password}\"";
$logger->info("  Restoring the backup to the destination database...");
$logger->debug("    $command");
system "$command";

#--------------------------------------------------------------------
# Remove the backup file
#--------------------------------------------------------------------
$command = "rm -f $db_backup_filename";
$logger->debug("    $command");
system "$command";

=head2 validate_args()

Validates all input arguments. Nothing is returned, the subroutine simply validates each
against a regex string, and calls pod2usage() if an invalid argument was found. This will
print the usage and exit the program.

    Input
        args - Hash array of all input arguments

=cut
sub validate_args {
# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	#--------------------------------------------------------------------
	# config_file
	#--------------------------------------------------------------------
	unless (defined($args{config_file})) { pod2usage("\nThe -configfile option is not set\n"); }

	#--------------------------------------------------------------------
	# logLevel
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	if (defined($args{log_level})) {
		unless ($args{log_level} =~ m/\b(TRACE|DEBUG|INFO|WARN|ERROR|FATAL)\b/) { pod2usage("\nThe -loglevel option is not set properly\n"); }
	}
}