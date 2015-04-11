#!/bin/env perl;

use strict;
use warnings;

my @fileContents;

###########################
# sub routines start here #
###########################

sub process {
 foreach (@fileContents) {
    # need to process the text here calling sub routines to process text
    #print $_;

    #while ($_ =~ /##/) { # add other characters in OR clause # assumes only one header per line
    
    ###############################################################
    #if ($_ =~ /###/) { # consider split out to new sub if too long
    #  $_ = &transformH3($_);
    #}
    #elsif (($_ =~ /##/) && !($_ =~ /###/)) {
    #  $_ = &transformH2($_);
    #}
    #elsif (($_ =~ /#/) && !($_ =~ /##/)) {
    #  $_ = &transformH1($_);
    #}
    #############################################################
    
    if ($_ =~ /#/) {
    	$_ = &header($_);
    }
    
    #}

    print FILE2 $_."\n"; # write current line to file
  }
}

sub header {
	if ($_ =~ /#{4,}/) {
		print "match #### or > \n";
		$_ =~ s/#{4,} /<h3>/;
		$_ =~ s/\h/<\/h3>/; # need way to find second occurance of space
		print $_;
		return $_;
	}
}

sub transformH1 { #catch 1 hash symbol
  print "found # \n";
  $_ =~ s/#/<h1>/;
  return $_;
}

sub transformH2 { # catch 2 hash symbols
  print "found ## \n";
  $_ =~ s/##/<h2>/;
  return $_;
}

sub transformH3 { # catch all with > 3 hash symbols
  print "found ### \n";
  $_ =~ s/###/<h3>/;
  return $_;
}

# code requirement

sub list {

}

sub text {

}

sub links {

}

############################
# main section starts here #
############################

# Getting input arguments
my $input = $ARGV[0]; # CONSIDER CHECKING FOR MORE THAN TWO ARGUMENTS FOR BONUS MARKS
my $output = $ARGV[1]; # might need to check if file exists

#print "number of items in ARGV is: ".scalar @ARGV."\n";

# Open input and output files
open FILE1, "<", $input or die "Could not open input file\n";
open FILE2, ">", $output or die "Could not open output file\n";

@fileContents = <FILE1>;

&process(@fileContents);

#stuff happens here


# Closing input files
close FILE1 or die $!;
close FILE2 or die $!;





