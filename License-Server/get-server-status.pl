#!/usr/bin/perl -w
use strict;

my $cmd = 'curl -s -S -i http://172.18.190.138:9502/api/v1/server/status';
my ($count) = @ARGV;
if (!defined($count)) {
	$count = 10;
}

sub queryServerStatusSequentially {
	for (my $i = 0; $i < $count; $i++) {
		print "Test case ", $i + 1, ":\n";
		print "$cmd\n";
		print `$cmd`, "\n";
	}
}

sub queryServerStatusConcurrently {
	while (1) {
	my $cmdAll = '';
	for (my $i = 0; $i < $count; $i++) {
		$cmdAll .= $cmd;
		$cmdAll .= ';';
	}

	print $cmdAll, "\n";
	print `$cmdAll`, "\n";
}
}

if ((@ARGV == 2) && ($ARGV[0] =~ /^\d+$/) &&
   	(($ARGV[1] =~ /^s$/i) || ($ARGV[1] =~ /^c$/i) || ($ARGV[1] =~ /^sequentially$/) || ($ARGV[1] =~ /^concurrently$/))) { 
	if (($ARGV[1] =~ /^s$/i) || ($ARGV[1] =~ /^sequentially$/)) {
		queryServerStatusSequentially();
   	} else {
 		queryServerStatusConcurrently();
	}
} else {
	print("Description:\n");
	print("  Query License Server's status for a number of times.\n");
	print("Arguments:\n");
	print("  [number-of-queries]  [Sequentially | Concurrently]\n");
	print("Example:\n");
	print("  ./thisPerlScript  100  c\n");
}
