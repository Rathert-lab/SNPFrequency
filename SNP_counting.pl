#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper qw(Dumper);

####################################################################################################
#
# Script written by Tabea Bauer tabea.bauer@ibtb.uni-stuttgart.de February 2020
#
# This script takes as input a vcf file containing SNPs called by FreeBayes and a bed region file.
# It then determines the amount of SNPs per region and calculates ther frequency (Snps/1000 bp).
#
#####################################################################################################

my $SNPfile = $ARGV[0];				# input vcf file from the FreeBayes SNP call via commandline
my $peakfile = $ARGV[1];						# input bed file containing the regions via commandline

if( ! defined $SNPfile | ! defined $peakfile ) {
    die "please provied name for the SNP file and peakfile after the command";
}

my $outfile = "${SNPfile}_counted.txt";							# name for the output file
my @items;

my %SNPs, my %regions, my %counts;

# opening all files

open(my $fhSNPs, '<:encoding(UTF-8)', $SNPfile) or die "Could not open file '$SNPfile' $!";
open(my $fhregions, '<:encoding(UTF-8)', $peakfile) or die "Could not open file '$peakfile' $!";
open(my $fhoutfile, '>:encoding(UTF-8)', $outfile) or die "Could not open file '$outfile' $!";

print $fhoutfile "Chromo\tStartpos\tStoppos\tSNPcount\tSNPs/1kb\n";		# prints the header for the output file

# write all SNPs into a hash

while (my $row = <$fhSNPs>) {
	chomp $row;
	if ($row =~ m/(chr\w+)\t(\d+)\t\S+\t\S+\t\S+\t\S+\t\S+\t\S+TYPE=snp\t/){
		$SNPs{$1}{$2} = '';
	}
}

# write regions into a hash
my $i = 1;
while (my $row = <$fhregions>) {
	chomp $row;
	@items = split(/\t/, $row);
	$regions{$items[0]}{"$items[1],$items[2]"} = "Region $i";
	$i++;
}

foreach my $chromo (keys %regions) {
	my @SNPs = keys %{$SNPs{$chromo}};
	foreach my $startstop (keys %{$regions{$chromo}}) {
		my @startstop = split(/,/, $startstop);
		my $j = 0;
		foreach my $SNP (@SNPs) {
			if ($SNP >= $startstop[0] && $SNP <= $startstop[1]){
			$j = $j+1;
			}
		}
		my $regionsize = $startstop[1]-$startstop[0]+1;
		my $SNPPH = $j/$regionsize*1000;				# calculate amount of SNPs in the region per 1kb
		$counts{$chromo}{$startstop} = $j;
		print $fhoutfile "$chromo\t$startstop[0]\t$startstop[1]\t$j\t$SNPPH\n";
	}
}

exit;
