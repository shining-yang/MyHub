#!/usr/bin/perl -w
use strict;

if (@ARGV < 1) {
   print 0;
   exit 0;
}

my ($ip) = @ARGV;
my $id = 0;

if ($ip =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/) {
    $id = $3 * 256;
    $id += $4;
    $id *= 1000;
}

print $id;
