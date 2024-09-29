#!/usr/bin/perl

# This utility will stop processing includes once it reaches a blank line 
# Or a line that starts with anything other than '#include'
# If you want it to work properly, remove the blank lines between includes
#
# For example:
#
#   #include <vector>           #include <vector>
#                               #include <iostream>
#   #include <iostream>
# 
#
#   Will not alphabetize.       Will alphabetize.


use warnings;
use strict;

die "Must provide a file as an argument" unless $ARGV[0];

my $filepath = $ARGV[0];
my @includes;
my @remainder;

my $done_with_headers_flag = 0;
if (open my $fh, '+<', $filepath) {
    while (my $line = readline($fh)) {
        if (substr($line, 0, 8) eq '#include' && !$done_with_headers_flag) {
            push @includes, $line;
        } else {
            push @remainder, $line;
            $done_with_headers_flag = 1;
        }
    }
    close $fh;
}

my @sorted_includes = sort @includes;

# check if changes are correct
printf("%-40s %-40s\n", "Before:", "After:");

for (my $i = 0; $i < scalar @includes; ++$i) {
    my $temp_inc =  $includes[$i];
    my $temp_sort = $sorted_includes[$i];
    chomp $temp_inc;
    chomp $temp_sort;

    printf("%-40s %-40s\n", $temp_inc, $temp_sort);
}

prompt();

my @file_contents; 
push @file_contents, @sorted_includes, @remainder;

if (open my $fh, '>', $filepath) {
    foreach(@file_contents) {
        print $fh $_;
    }
    close $fh;
}

print "\nChanges written to $filepath. Exiting.\n";

sub prompt {
    print "\nDo you want to write and save these changes? [y/n]: ";
    my $response = <STDIN>;
    chomp $response;
    if ($response eq 'n' || $response eq 'N') {
        print "\nExiting.\n";
        exit 0;
    } elsif ($response eq 'y' || $response eq 'Y') {
        return;
    } else {
        prompt();
    }
}
