#!/usr/bin/perl -w
use strict;

open(I,"<$ARGV[0]");
my %c=();
my $curgid="";
while (<I>) {
	chomp;
	my @tmp = split /\t/;
	if ($tmp[2] eq "gene") { $curgid=$tmp[8]; $tmp[8]="ID=$tmp[8]";} else {
		if ($tmp[2] eq "transcript") {
			$tmp[2]="mRNA";
			$tmp[8]="ID=$tmp[8];Parent=$curgid";
		} else {
		my ($tid,$gid)=$tmp[8]=~/transcript_id \"(.*)\"\; gene_id \"(.*)\"/;
		my ($tid2)=$tid=~/(g\d+.*)/;
		my ($gid2)=$gid=~/(g\d+)/;
		$c{$tid2}++;
		$tmp[8]="ID=$tid2.$c{$tid2};Parent=$tid2";
		$curgid=$gid2;
	}
	}
	print "".join("\t",@tmp)."\n";
}
close I;
