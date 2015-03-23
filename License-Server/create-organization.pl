#!/usr/bin/perl -w
use strict;

my $cmd = 'curl -s -S -i -u "DJP:yhUMAXaSY8Aj" ';
my $url = '"http://172.18.190.38:9502/api/v1/organization?pretty=true" ';
my $opt = '-X POST -H "Content-Type:application/json" ';
my $req0 = '-d \'{"requests":[{"organization_id":"';
my $req1 = '","belongs_to_name":"Japan","belongs_to_type":"obu","time_zone":"+08:00"}]}\' ';

sub spawTestProcess {
	my ($org, $start, $count) = @_;
	for (my $i = $start; $i < $start + $count; $i++) { 
		print "Test case ", $i, ": \n";
	    my $c = $cmd.$url.$opt.$req0.$org.$i.$req1;
		print $c, "\n";
	    print `$c`, "\n";
	}
}

sub printUsage {
	print "Description:\n";
	print "  Create organizations in a loop.\n";
	print "Usage: (parameters)\n";
	print "  thisScriptFile organization-name  start-index  total-count\n";
}

if (@ARGV < 3) {
	printUsage();
} else {
	spawTestProcess(@ARGV);
}

