#!/usr/bin/perl -w
use strict;

open(I,"<$ARGV[0]");
my %gene=();
my %tran=();
my %gff=();
my @order=();
while (<I>) {
	chomp;
	if (/^\#/) { print "$_\n"; next }
	my @tmp = split /\t/;
	$tmp[1]=$ARGV[1];
	if ($tmp[2] eq "transcript") { next }
	if ($tmp[2] eq "gene") { next }
	if ($tmp[2] eq "exon") { next }
	if ($tmp[$#tmp]=~/transcript_id \"([^\"]*)\".*gene_id \"([^\"]*)\"/) { 
		my $t=$1; my $g=$2;
		if ($g=~/cluster/) { $t.=".t1"; $tmp[$#tmp]="transcript_id \"$t\"; gene_id \"$g\";" }
		push @order, [ ($g, $t) ];
	 	push @{$gff{$g}{$t}}, join("\t",@tmp) ;
		if (($tmp[2] eq "CDS")||($tmp[2]=~/UTR/)) { $tmp[2]="exon"; push @{$gff{$g}{$t}}, join("\t",@tmp) ; }
		if (not exists $gene{$g}) { $gene{$g}{1}=$tmp[3]; $gene{$g}{2}=$tmp[4]; $gene{$g}{3}=$tmp[6]; $gene{$g}{4}=$tmp[0];}
		if (not exists $tran{$t}) { $tran{$t}{1}=$tmp[3]; $tran{$t}{2}=$tmp[4]; $tran{$t}{3}=$tmp[6]; $tran{$t}{4}=$tmp[0]; $tran{$t}{5}=$g; }

		if ($tmp[3] < $gene{$g}{1} ) { $gene{$g}{1}=$tmp[3] }
		if ($tmp[4] < $gene{$g}{1} ) { $gene{$g}{1}=$tmp[4] }
		if ($tmp[3] > $gene{$g}{2} ) { $gene{$g}{2}=$tmp[3] }
                if ($tmp[4] > $gene{$g}{2} ) { $gene{$g}{2}=$tmp[4] }

		if ($tmp[3] < $tran{$t}{1} ) { $tran{$t}{1}=$tmp[3] }
                if ($tmp[4] < $tran{$t}{1} ) { $tran{$t}{1}=$tmp[4] }
                if ($tmp[3] > $tran{$t}{2} ) { $tran{$t}{2}=$tmp[3] }
                if ($tmp[4] > $tran{$t}{2} ) { $tran{$t}{2}=$tmp[4] }

	}
}
close I;

my %seen=();
for my $xx (0..$#order) {
	my $x=$order[$xx][0];
	my $y=$order[$xx][1];
	if (exists $seen{"$x-$y"}) { next }
	$seen{"$x-$y"}=1;
	if (exists $seen{$x}) { } else { 
  print "$gene{$x}{4}\t$ARGV[1]\tgene\t$gene{$x}{1}\t$gene{$x}{2}\t.\t$gene{$x}{3}\t.\tgene_id \"$x\";\n"; $seen{$x}=1;  }
  print "$tran{$y}{4}\t$ARGV[1]\ttranscript\t$tran{$y}{1}\t$tran{$y}{2}\t.\t$tran{$y}{3}\t.\ttranscript_id \"$y\"; gene_id \"$x\";\n"; 
  print "".join("\n",@{$gff{$x}{$y}})."\n";
}

