#!/usr/bin/perl -w
use strict;

#
# The following parameters can be used to customize generated scripts.
# Typically, you might customize `$port_count` and `$script_file_count` to meet your needs,
# as they stand for HOW-MANY-SNMP-DEVICES each snmpsimd instance will simulate and
# HOW-MANY-INSTANCE-SCRIPT will be generated, respectively.
#
my ($host_ip)	= @ARGV;		# IPv4 of local host that will be listened 

my $start_port	= 50000;		# Start port NO.
my $port_count	= 200;			# Number of ports supported within each script file
								# ALSO, it's the number of the simulated devices within an instance
my $id_offset	= 1000;			# Transport id offset for SNMPSIMD
my $output_file_prefix = 'sim-';	# prefix of generated script file name
my $output_file_count = 10;		# number of script to generate

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

for (my $n = 0; $n < $output_file_count; $n++) {
	my $output_file_name = $output_file_prefix.$start_port."-".($start_port + $port_count - 1); # the output file name

	open(F, ">", $output_file_name) or die "Fail to open file: $!";
	print F "#!/bin/sh\n";
	print F "# This is an auto-generated file which will be used to launch as an SNMP simulator.\n";
	print F "\n# 1. Generate SNMP simulator argument files\n";
	print F $script1.$host_ip." ".$start_port." ".($start_port + $port_count - 1)."\n";
	print F "\n# 2. Build SNMP simulator transport id\n";
	print F $script2.$id_offset." ".$port_count."\n";
	print F "\n# 3. Run simulator\n";
	print F $script3.$id_offset." --args-from-file=./tmp/sim_port_".$start_port."_".($start_port + $port_count - 1).".txt\n";
	close F;

	my $cmd = "chmod +x ".$output_file_name;
	`$cmd`;

	$start_port += $port_count;
	$id_offset += $port_count;
}

print "SNMP simulator startup scripts generated. Please check them out.\n";
