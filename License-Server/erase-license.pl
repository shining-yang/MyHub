#!/usr/bin/perl -w
use strict;
use 5.010;

my $cmd = 'curl -i -s -S -u "DJP:yhUMAXaSY8Aj" -X DELETE ';
my $url = 'http://172.18.190.38:9502/api/v1/organization/%ORGID%/licenses/';
my $modifier = '?pretty=true';

sub printUsage {
	my @usage = (
		qq/Description:/,
		qq/  Erase the licenses which stored in a file/,
		qq/Usage:/,
		qq/  thisPerlScript  organizationName  fileLicenseID/,
		qq/Example:/,
		qq<  ./thisPerlScript  myTestOrg01  licenses.txt>
	);

	say join "\n", @usage;
}

# TEST CASE for erase licenses
sub eraseLicenses {
	my ($orgId, $licFile) = @_;
	my $myUrl = $url;
	$myUrl =~ s/%ORGID%/$orgId/;

	open(LICFILE, '<', $licFile) or die "Cannot open the file: $licFile\n";
	while (<LICFILE>) {
		chomp;

		state $n = 0;
		print "Test case", $n++, ":\n";
		my $c = $cmd.$myUrl.$_.$modifier;
		print("$c\n");
		print `$c`, "\n";
	}
	close LICFILE;
}

if (@ARGV < 2) {
	printUsage();
} else {
	eraseLicenses(@ARGV);
}

