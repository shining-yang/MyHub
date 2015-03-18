#!/usr/bin/perl -w
use strict;

my $cmd = 'curl -u "DJP:yhUMAXaSY8Aj" -X DELETE ';
my $url = 'http://172.18.190.38:9502/api/v1/organization/';
my $opt = '?pretty=true';

sub spawTestProcess {
	my ($org, $start, $count) = @_;
	for (my $i = $start; $i < $start + $count; $i++) { 
	    my $c = $cmd.$url.$org.$i.$opt;
		print `$c`, "\n";
	}
}

sub printUsage {
	print "Description:\n";
    print "  Delete organizations in a loop.\n";
	print "Usage:\n";
	print "  scriptFile organization-name  start-index  total-count\n";
	print "Example:\n";
	print "  ./thisPerlScript  TEST-ORG  0  100\n";
}

if (@ARGV < 3) {
	printUsage();
} else {
	print "Test begins. Making API requests...\n";
	#print @ARGV;
	spawTestProcess($ARGV[0], $ARGV[1], $ARGV[2]);
}


