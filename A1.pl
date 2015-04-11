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
    
    if ($_ =~ /#/) { # headers
    	$_ = &header($_);
    }
    elsif ($_ =~ /\*[a-zA-Z]\*/) { # emphasis & bold
		$_ = &text($_);
    }
    elsif ($_ =~ /\*/ || $_ =~ /[0-9]\./) { # Lists
		$_ = &list($_);
    }
    elsif ($_ =~ /\[{a-zA-Z}+\]/) { # links
		$_ = &links($_);
    }
    
    #}

    print FILE2 $_."\n"; # write current line to file
  }
}

sub header { # need to consider check for space or newline at end
	if ($_ =~ /#{4,}/) {
		print "match #### or > \n";
		$_ =~ s/#{4,} /<h3>/;
		#$_ =~ s/\h/<\/h3>/; # need way to find second occurance of space
		
		if ($_ =~ /\h/) {
			$_ =~ s/\h/<\/h3>/; 
		}
		else {
			chomp($_);
			$_ = $_."<\/h3>\n";
		}
		
		print $_;
		return $_;
	}
	elsif ($_ =~ /###/) {
		print "match ### \n";
		$_ =~ s/### /<h3>/;
		#$_ =~ s/\h/<\/h3>/;
		
		if ($_ =~ /\h/) {
			$_ =~ s/\h/<\/h3>/; 
		}
		else {
			chomp($_);
			$_ = $_."<\/h3>\n";
		}
		
		print $_;
		return $_;
	}
	elsif ($_ =~ /##/) {
		print "match ## \n";
		$_ =~ s/## /<h2>/;
		#$_ =~ s/\h/<\/h2>/;
		
		if ($_ =~ /\h/) {
			$_ =~ s/\h/<\/h2>/; 
		}
		else {
			chomp($_);
			$_ = $_."<\/h2>\n";
		}
		
		print $_;
		return $_;
	}
	elsif ($_ =~ /#/) {
   	print "match \n";
   	$_ =~ s/# /<h1>/;
   	#$_ =~ s/\h/<\/h1>/;
   	
   	if ($_ =~ /\h/) {
			$_ =~ s/\h/<\/h1>/; 
		}
		else {
			chomp($_);
			$_ = $_."<\/h1>\n";
		}
   	
   	print $_;
   	return $_;
	}
}

# code requirement

sub list {
	return $_;
}

sub text {
	if ($_ =~ /\*[a-zA-Z]+\*/) {
		#print "matched on \*text\* \n";
		$_ =~ s/\*/\<em\>/;
		$_ =~ s/\*/\<\/em\>/;
		print $_;
		return $_;
	}
	
	if ($_ =~ /\*\*[a-zA-Z]+\*\*/) {
		#print "matched on \*\*text\*\* \n";
		$_ =~ s/\*\*/\<strong\>/;
		$_ =~ s/\*\*/\<\/strong\>/;
		print $_;
		return $_;
	}
	
	return $_;
}

sub links {
	return $_;
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





