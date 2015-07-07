#!/usr/bin/perl -w
use strict;

#####################################################################
#
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
####################################################################

my $mac_prefix = '001a'; # MAC starts with '001a'

# Better efficiency without bounds checking. Assume that ARGV is available

# my ($data_file) = @ARGV;
# $num = 0 unless $num; 
# print "$num is: ", $num, "\n";

#
# Generate a MAC based on the input numeric
#
sub generate_mac_str {
	my ($id) = @_;
	$id = 0 unless defined $id;
	return sprintf("%s%08x", $mac_prefix, $id);
}

#
# Parse the argument which is something like: /usr/home/data/1.3.6.1.6.1.1.0.snmprec
# We'll get the last number
#

my $num = 0;
unless (@ARGV < 1) {
	my @args = split('\.', $ARGV[0]);
	pop @args;
	$num = pop @args;
}

print &generate_mac_str($num);

