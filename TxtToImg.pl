#! /usr/bin/perl
use warnings;
use strict;
use File::Find;

my @all_file_names;

my $path = '/data/input';
my $outpath = '/data/output';

find sub {
    return if -d;
    push @all_file_names, $File::Find::name;
}, $path ;
@all_file_names = sort(@all_file_names);
my $i = 1;
for my $path ( @all_file_names ) {
    if ($path =~ m/^(.*\/)([^.]*?)(\.[Jj][Pp][Gg])$/){
        print  "$1 $2 $3";
        #print  system("pdftotext -eol mac '$1$2$3' '$1$2.txt'");
        print  "\n";
        my $name=$2;
        $name =~ s/_/-/;
        my $outname = sprintf("%04d",$i);
        print "convert $path  -gravity SouthEast -fill black -stroke \"#aaaaaa\" -pointsize 72 -draw \"text 50,30 '$name'\" $outpath$outname.jpg\n";
        print system("convert $path  -gravity SouthEast -fill black -stroke \"#aaaaaa\" -pointsize 72 -draw \"text 50,30 '$name'\" $outpath$outname.jpg");
        print "\n";
        $i = $i + 1;
    }
}
