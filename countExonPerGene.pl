#!/usr/bin/perl -w
use strict;

my %ipro=();
open(I,"<$ARGV[1]");
while (<I>) {
	chomp;
	my @tmp = split /\t/;
	$ipro{$tmp[0]}=1;
}
close I;

open(I,"<$ARGV[0]");
my %curcount=();
while (<I>) {
	chomp;
	if (/^\#/) { next }
	my @tmp = split/\t/;
	if ($tmp[2] eq "exon") {
		if ($tmp[8]=~/Name/) {
	 my ($name)=$tmp[8]=~/Name=([^\;]*)/;
	 $curcount{$name}++;
 }
 if ($tmp[8]=~/Parent=([^\;]*)/) { $curcount{$1}++ }
	}
}
close I;

my $se=0;
my $me=0;
my $se_i=0;
my $me_i=0;
for my $x (keys %curcount) {
	print "$x\t$curcount{$x}\n";
 if ($curcount{$x}>1) { $me++; if (exists $ipro{$x}) { $me_i++ } }
 if ($curcount{$x}==1) { $se++; if (exists $ipro{$x}) { $se_i++ } }
}

print "me=$me ($me_i) se=$se ($se_i) \n";

