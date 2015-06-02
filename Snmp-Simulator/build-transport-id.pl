#!/usr/bin/perl -w
use strict;

#####################################################################
#
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
####################################################################

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

my ($path, $i, $n) = @ARGV;
print("Finish creating symbolic links to file.\n");
&create_symbolic_links($path, $i, $n);

