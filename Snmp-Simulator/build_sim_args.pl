#!/usr/bin/perl -w
use strict;

sub print_usage {
	my $usage = '';
	$usage .= qq{Usage:\n};
	$usage .= qq{\tTHIS-PERL-SCRIPT  START-PORT-NO  END-PORT-NO\n};
	$usage .= qq{Example:\n};
	$usage .= qq{\t'THIS-PERL-SCRIPT  50000  50099' will generate a file called 'sim_port_50000_50099.txt' };
    $usage .= qq{which contains a series of simulated ip:port arguments for snmpsimd utility.\n\n};
	print $usage;
}

sub print_usage_and_exit {
	print_usage();
	exit(0);
}

if (scalar(@ARGV) < 2) {
	print_usage_and_exit();
}

my ($start_port, $end_port) = @ARGV;

if (($start_port =~ /^[1-9]+\d*$/) && ($end_port =~ /^[1-9]+\d*$/)) {
	# OK. We need numerics here
} else {
	print "You must specify numerics here.\n";
	exit(0);
}

if ($start_port > $end_port) {
	print "Start-Port must not greater than End-Port.\n";
	exit(0);
}

print_usage_and_exit() if ($start_port <= 0 || $end_port <= 0);

### Begin to generate file after verify arguments

my $args = '--agent-udpv4-endpoint=172.18.190.13';
my $output_file = 'sim_port_'.$start_port.'_'.$end_port.'.txt';
my $now_time = localtime();

# starting
my $prologue = qq{Operation starting...\n};
print $prologue;

open(OFILE, '>', $output_file) or die "Cannot open file '$output_file' for write: ", $!;
print OFILE "#\n";
print OFILE "# Sample usage: snmpsimd --args-from-file=", $output_file, "\n";
print OFILE "# File generated at: ", $now_time, "\n";
print OFILE "#\n";

foreach my $port ($start_port .. $end_port) {
	print OFILE $args.':'.$port, "\n";
}
close(OFILE);

# completed
my $epilogue = qq{Operation completed. Please check the generated file: '$output_file'.\n};
print $epilogue;

