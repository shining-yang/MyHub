#!/usr/bin/perl -w
use strict;

#####################################################################
#
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
####################################################################

my $pwd = `pwd`;
chomp $pwd;

#
# NOTE: 
# Without any validations fro simplicity and efficiency.
# You MUST provide the required arguments correctly.
#
sub create_symbolic_links {
	my ($path, $start_id, $total_count) = @_;
	if (substr($path, -1) ne '/') {
		$path .= '/';
	}

	if (substr($path, 0, 2) eq './') {
		$path = substr($path, 2);
		$path = $pwd.'/'.$path;
		# print $path, "\n\n";
	}

	my $path_output = './tmp/';
	if (! -d 'tmp') {
		`mkdir tmp`;
	}

	my $base_file = 'base.snmprec.bak';
	my $file_name_prefix = '1.3.6.1.6.1.1.';
	my $file_name_extension = '.snmprec';

	for (my $id = $start_id; $id < $start_id + $total_count; $id++) {
		my $cmd = "ln -s ";
		$cmd .= $path;
		$cmd .= $base_file;
		$cmd .= ' ';
		$cmd .= $path_output;
		$cmd .= $file_name_prefix;
		$cmd .= $id;
		$cmd .= $file_name_extension;

		# print $cmd, "\n";

		`$cmd`;
	}
}

sub print_usage {
	print("Usage:\n");
	print("\tTHIS-SCRIPT  PATH-TO-BASE-SNMPREC  START-ID  TOTAL-ID-COUNT\n");
	print("Example:\n");
	print("\tTHIS-SCRIPT  ./static/DES-3028  10  2\n");
}


if (@ARGV < 3) {
	print_usage();
	exit(0);
}

print("Creating symbolic links ...\n");
my ($path, $i, $n) = @ARGV;
&create_symbolic_links($path, $i, $n);
print("Operation commpleted.\n");

