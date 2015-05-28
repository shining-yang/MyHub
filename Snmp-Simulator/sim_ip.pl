#!/usr/bin/perl -w
use strict;

my $start_port = 50000;
my $args = '--agent-udpv4-endpoint=172.18.190.13';
my $output_file = 'sim_ip.txt';
my $now_time = localtime();

print "This little perl script will generate a file 'sim_ip.txt', which contains a series of simulated ip:port arguments for snmpsimd utility.\n";

open(OFILE, '>', $output_file) or die "Cannot open file '$output_file' for write: ", $!;
print OFILE "#\n";
print OFILE "# Sample usage: snmpsimd --args-from-file=sim_ip.txt\n";
print OFILE "# File generated at: ", $now_time, "\n";
print OFILE "#\n";

foreach my $n (0 .. 999) {
	print OFILE $args.':'.($n + $start_port), "\n";
}
close(OFILE);

# completed
print "Operation completed. Please check the generated file 'sim_ip.txt'.\n";

