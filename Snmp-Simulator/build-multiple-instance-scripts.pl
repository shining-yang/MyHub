#!/usr/bin/perl -w
use strict;

my $script1 = 'perl build-simulator-args.pl ';
my $script2 = 'perl build-transport-id.pl ./static/DES-3028 ';
my $script3 = 'snmpsimd --v2c-arch --data-dir=./tmp --transport-id-offset=';


my ($hostip) = @ARGV;
my $startport = 50000;
my $count = 100;
my $idoffset = 1000;
my $file = 'sim';

if (@ARGV < 1) {
	print "Usage:\n";
	print "\tSCRIPT  host-ip\n";
	exit(0);
}

for (my $n = 0; $n < 10; $n++) {
	open(F, ">", $file.$n) or die "Fail to open file: $!";
	print F $script1.$hostip." ".$startport." ".($startport + $count - 1)."\n\n";

	print F $script2.$idoffset." ".$count."\n\n";

	print F $script3.$idoffset." --args-from-file=./tmp/sim_port_".$startport."_".($startport + $count - 1).".txt\n\n";
	close F;

	$startport += $count;
	$idoffset += $count;
	
	my $cmd = "chmod +x ".$file.$n;
	`$cmd`;
}
