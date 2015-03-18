#!/usr/bin/perl -w
use strict;
use 5.010;

my $cmd = 'curl ';
my $url = 'http://172.18.190.38:9502/api/v1/organization/';
my $orgId = '';
my $licId = '';
my $user = 'y.s.n';

sub printUsage {
	my @usage = (
		qq/Description:/,
		qq/  Deposit licenses from a file that contains license-ids./,
		qq/Usage:/,
		qq/  theScriptFile  theFileContainsLicenses/,
		qq/Example:/,
		qq/  theScriptFile  licenses.txt/
	);

	foreach (@usage) {
		say;
	}
}

printUsage();

