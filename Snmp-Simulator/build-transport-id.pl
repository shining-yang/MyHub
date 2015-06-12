#!/usr/bin/perl -w
use strict;

#####################################################################
#
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
####################################################################

my $mac_prefix = '001a1a1a'; # mac prefix for simulated snmp devices
my $mac_placeholder = '001c1c1c1c1c';
my $device_name_placeholder = 'DEVICE-NAME-XX';
my $pwd = `pwd`;
chomp $pwd;


sub generate_device_name_by_id {
	my ($id) = @_;
	$id = 0 unless defined $id;
	$id &= 0xFFFF;
	return sprintf("SIM-dev-%d", $id);
}

sub generate_mac_by_id {
	my ($id) = @_;
	$id = 0 unless defined $id;
	$id &= 0xFFFF;
	return sprintf("%s%04x", $mac_prefix, $id);
}

sub replace_file_content_string {
	my ($file, $old_str, $new_str) = @_;
	open(F, "<", $file) or die("Fail to open file: $!");
	my @file_contents = <F>;
	close F;
	
	# print("Parameters: old-str: ", $old_str, ", new_str: ", $new_str, "\n");
	
	foreach (@file_contents) {
		s/$old_str/$new_str/g;
	}
	
	open(F, ">", $file) or die("Fail to open file for write: $!");
	print F @file_contents;
	close F;
}

#
# NOTE: 
# Without any validations fro simplicity and efficiency.
# You MUST provide the required arguments correctly.
#
sub create_snmp_records {
	my ($path, $start_id, $total_count) = @_;
	if (substr($path, -1) ne '/') {
		$path .= '/';
	}

	if (substr($path, 0, 2) eq './') {
		$path = substr($path, 2);
		$path = $pwd.'/'.$path;
		# print $path, "\n\n";
	} elsif (substr($path, 0, 1) ne '/') {
		$path = $pwd.'/'.$path;
	}

	my $path_output = './tmp/';
	if (! -d 'tmp') {
		`mkdir tmp`;
	}

	##########################################################################
	# CURRENTLY supported device types, THESE words must be directory names
	##########################################################################
	my @support_types = qw(DAP-3690 DES-3028 DWS-4026);

	my $base_file = 'base.snmprec.bak';
	my $file_name_prefix = '1.3.6.1.6.1.1.';
	my $file_name_extension = '.snmprec';

	for (my $id = $start_id; $id < $start_id + $total_count; $id++) {
		my $support_index = $id % (@support_types);
		my $output_file_name = $path_output.$file_name_prefix.$id.$file_name_extension;

		# my $cmd = "ln -s ";
		my $cmd = "cp ";
		$cmd .= $path;
		$cmd .= '/';
		$cmd .= $support_types[$support_index];
		$cmd .= '/';
		$cmd .= $base_file;
		$cmd .= ' ';
		$cmd .= $output_file_name;

		# print $cmd, "\n";
		`$cmd`;
		
		### Replace file content with specific string, lazy method.
		my $new_mac = &generate_mac_by_id($id);
		&replace_file_content_string($output_file_name, $mac_placeholder, $new_mac);

		my $new_device_name = &generate_device_name_by_id($id);
		&replace_file_content_string($output_file_name, $device_name_placeholder, $new_device_name);
	}
}

sub print_usage {
	print("Usage:\n");
	print("\tTHIS-SCRIPT  PATH-OF-SNMPREC  START-ID  TOTAL-ID-COUNT\n");
	print("Example:\n");
	print("\tTHIS-SCRIPT  ./static  10  2\n");
}

if (@ARGV < 3) {
	print_usage();
	exit(0);
}

print("Creating transport-based snmp records ...\n");

my ($path, $start_id, $count) = @ARGV;
&create_snmp_records($path, $start_id, $count);

print("Operation commpleted.\n");

