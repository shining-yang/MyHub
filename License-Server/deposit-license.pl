#!/usr/bin/perl -w
use strict;
use 5.010;

my $cmd = 'curl -s -S -i -u "DJP:yhUMAXaSY8Aj" -H "Content-Type:application/json" -X POST ';
my $url = 'http://172.18.190.38:9502/api/v1/organization/%ORGID%/licenses ';
my $req = '-d \'{"requests":[{"license_id":"%LICID%","deposited_by":"%USER%"}]}\'';
my $user = 'y.s.n@live.com';

sub printUsage {
	my @usage = (
		qq/Description:/,
		qq/  Deposit licenses from a file that contains license-ids./,
		qq/Usage:/,
		qq/  theScriptFile  organizationID  theFileContainsLicenses/,
		qq/Example:/,
		qq/  theScriptFile  org01  licenses.txt/
	);

	foreach (@usage) {
		say;
	}
}

sub depositLicenses {
	my ($orgId, $fileLicense) = @_;
	my $myUrl = $url;
	$myUrl =~ s/%ORGID%/$orgId/;
	
	open(LICFILE, '<', $fileLicense) or die "Cannot open the file: $fileLicense\n";
	foreach (<LICFILE>) {
		chomp;
		my $myReq = $req;
		$myReq =~ s/%LICID%/$_/;
		$myReq =~ s/%USER%/$user/;
		
		my $c = $cmd.$myUrl.$myReq;
		
		state $n = 0;
		print "Test case ", ++$n, ": \n";
		print $c, "\n";
		print `$c`, "\n";
	}

	close LICFILE;
}

if (@ARGV < 2) {
	printUsage();
} else {
	depositLicenses(@ARGV);
}
