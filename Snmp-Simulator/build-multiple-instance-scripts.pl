#!/usr/bin/perl -w
use strict;

#
# The following parameters can be used to customize generated scripts.
# Typically, you might customize `$port_count` and `$script_file_count` to meet your needs,
# as they stand for HOW-MANY-SNMP-DEVICES each snmpsimd instance will simulate and
# HOW-MANY-INSTANCE-SCRIPT will be generated, respectively.
#
my ($hostip)	= @ARGV;
my $start_port	= 50000;		# Start port NO.
my $port_count	= 500;			# Number of ports supported within each script file
my $id_offset	= 1000;			# Transport id offset for SNMPSIMD
my $script_file	= 'sim';		# prefix of generated script file name
my $script_file_count = 10;		# number of script to generate

if (@ARGV < 1) {
	print "Usage:\n";
	print "\tSCRIPT  local-host-ip-to-listen\n";
	print "Example:\n";
	print "\tSCRIPT  172.18.190.46\n";
	exit(0);
}


my $script1 = 'perl build-simulator-args.pl ';
my $script2 = 'perl build-transport-id.pl ./static ';
my $script3 = 'snmpsimd --v2c-arch --data-dir=./tmp --transport-id-offset=';

for (my $n = 0; $n < $script_file_count; $n++) {
	open(F, ">", $script_file.$n) or die "Fail to open file: $!";
	print F $script1.$hostip." ".$start_port." ".($start_port + $port_count - 1)."\n\n";
	print F $script2.$id_offset." ".$port_count."\n\n";
	print F $script3.$id_offset." --args-from-file=./tmp/sim_port_".$start_port."_".($start_port + $port_count - 1).".txt\n\n";
	close F;

	my $cmd = "chmod +x ".$script_file.$n;
	`$cmd`;

	$start_port += $port_count;
	$id_offset += $port_count;
}

print "Operation completes.\n";
