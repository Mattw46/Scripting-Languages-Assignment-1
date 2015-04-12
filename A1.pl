#!/bin/env perl;

use strict;
use warnings;

my @fileContents;

###########################
# sub routines start here #
###########################

# Process each line from text file. calls sub-routine when character is matched
sub process {
 foreach (@fileContents) {
	# Test for presence of defined characters, loops until no characters detected
    while ($_ =~ /^ ?#/ || $_ =~ /\*/ || $_ =~ /\[/) { 
		if ($_ =~ /#/) {
			$_ = &header($_); # processed string returned from sub-routine
		}
		if ($_ =~ /\*/) {
			$_ = &text($_);
		}
		if ($_ =~ /\*/) {
			$_ = &links($_);
		}
    }

    print FILE2 $_."\n"; # write current line to file
  }
}

# processes all lines where a # is matched, applies header tag according to number of occurances.
sub header { # need to consider check for space or newline at end
	if ($_ =~ /#{4,}/) {
		$_ =~ s/###(#)? ?/<h3>/;
		$_ =~ s/(\s||\.)$/<\/h3>/;
		return $_;
	}
	elsif ($_ =~ /###/) {
		$_ =~ s/### ?/<h3>/;
		$_ =~ s/(\s||\.)$/<\/h3>/;
		return $_;
	}
	elsif ($_ =~ /##/) {
	    $_ =~ s/## ?/<h2>/;
		$_ =~ s/(\s||\.)$/<\/h2>/;
	    return $_;
	}
	elsif ($_ =~ /#/) {
		$_ =~ s/# ?/<h1>/;
		$_ =~ s/(\s||\.)$/<\/h1>/;
		return $_;
	}
}

# processes code blocks
sub codeBlock {
	# Did not have enough time to implement.
}

# process lists when a single * proceeds text or number & dot (1.)
sub list {
	# Did not have enough time to implement.
}

# process lines with matching pair of * or ** applied <strong> or <em> tags
sub text {
	if ($_ =~ /\*\*/) { # substitute <strong>
		$_ =~ s/\*\*/<strong>/;
		$_ =~ s/\*\*/<\/strong>/;
	}
	if ($_ =~ /\*/) { # substitute <em>
		$_ =~ s/\*/<em>/;
		$_ =~ s/\*/<\/em>/;
	}
	return $_;
}

# processed lines matching a link as defined by '[' character, applies <a href=""> tags
# text is reordered to match order defined in specification.
sub links {
	my $labelStart;
	my $labelEnd;
	my $linkStart;
	my $linkEnd;
	my $label;
	my $link;

	$labelStart = index($_, '[') + 1; # extract location of the link text
	$labelEnd = index($_, ']');
	$linkStart = index($_, '(') + 1; # extract location of URL
	$linkEnd = index($_, ')');

	$label = substr($_, $labelStart, ($labelEnd - $labelStart)); # extract link text and URL
	$link = substr($_, $linkStart, $linkEnd - $linkStart);

	# assemble string back into order as per specification
	my $temp = 
		substr($_, 0, $labelStart - 1)."<a href=\"".$link."\">".$label."<\/a>".
		substr($_, $linkEnd, length($_));
	$temp =~ s/\)/ /;
	return $temp;
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

@fileContents = <FILE1>; # extract file text into an array

&process(@fileContents); # send array to process sub-routine to process each line


# Closing input files
close FILE1 or die $!;
close FILE2 or die $!;




