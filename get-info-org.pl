#!/usr/bin/perl -w
use strict;
use 5.010;

my $cmd = 'curl -u "NTT:uByvA5ejaSu8" ';
my $url = 'http://172.18.190.17:9501/api/v1/organization/';
my $path = '/licenses';

my @orgs = (
	qq/54bf4902f5d7ce09400c10d1/,
	qq/54ea9ab59da33190230a1896/,
	qq/54ea99989da33190230a14b6/,
	qq/54f7ffbd9da33190233e177f/,
	qq/544952915a6f4a851000003b/,
	qq/55027efc0fd6f7131b0e77ee/,
	qq/54eeb0009da3319023189590/,
	qq/54dd76204a362da004219d85/
);

sub getOrgInfo {
	my $c = '';
	foreach (@orgs) {
		$c .= $cmd.$url.$_;
		$c .= '; ';
	}
	
	foreach (@orgs) {
		$c .= $cmd.$url.$_.$path;
		$c .= '; ';
	}
	
	$c = $c x 50;

	print `$c`, "\n";
}

for (my $i = 0; $i < 1; $i++) {
  getOrgInfo();
}
