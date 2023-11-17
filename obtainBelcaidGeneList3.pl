#!/usr/bin/perl -w
use strict;

open(I,"<$ARGV[1]");
my %cdscount=();
my %curcount=();

while (<I>) {
        chomp;
	if (/^\#/) { next }
        my @tmp = split/\t/;
        if ($tmp[2] eq "CDS") {
         my ($name)=$tmp[8]=~/Name=([^\;]*)/;
	 $cdscount{$name}++;
	 #if ($tmp[0]=~/unordered_in/) { $cdscount{$name}=1; $curcount{$name}=1; }
	 #if ($tmp[0]=~/unclustered/) { $cdscount{$name}=1; $curcount{$name}=1; }
 }
}
close I;

print STDERR "keys = ".keys(%cdscount)."\n";

my %uniq=();
open(I,"<$ARGV[0]");
while (<I>) {
	chomp;
	my @tmp = split/\t/;
	if ($tmp[2] eq "CDS") {
	 my ($name)=$tmp[8]=~/Name=([^\;]*)/;
	 $curcount{$name}++;
	}
}
close I;

for my $x (keys %curcount) {
 if ($curcount{$x}>$cdscount{$x}) { print STDERR "WTF $x\n" }
 if ($cdscount{$x}==1) { next }
 if (($curcount{$x}/$cdscount{$x})>=$ARGV[3]) { $uniq{$x}=1; print "$x\n"; }
}

open(I,"<$ARGV[1]");
open(O,">$ARGV[2]");
while (<I>) {
	chomp;
	if (/^\#/) { next }
	my @tmp = split /\t/;
	my ($name)=$tmp[8]=~/Name=([^\;]*)/;
	if (exists $uniq{$name}) { 
	 print O "$_\n";
	}
}
close I;
close O;
