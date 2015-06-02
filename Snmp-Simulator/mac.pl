#!/usr/bin/perl

#use warnings;
use strict;

my $mac_base = '001a1a1a0000';
my $mac_prefix = '001a1a1a'; # support 65535 MACs at most

# Better efficiency without bounds checking. Assume that ARGV is available
# my ($data_file) = @ARGV;
# $num = 0 unless $num; 
# print "$num is: ", $num, "\n";

#
# Generate a MAC based on the input numeric
#
sub generate_mac_str {
	my ($id) = @_;
	# $id += 0;
	# $id = 0 if $id < 0;
	# $id = 65535 if $id > 65535;
	return sprintf("%s%04x", $mac_prefix, $id);
}

#
# Parse the argument which is something like: /usr/home/data/1.3.6.1.6.1.1.0.snmprec
# We'll get the last number
#

my @args = split('\.', $ARGV[0]);
pop @args;
my $num = pop @args;
print &generate_mac_str($num), "\n";

