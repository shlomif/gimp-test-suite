#!/usr/bin/perl -w

use strict;
use warnings;

my $script_name = shift(@ARGV);

if ($script_name !~ m{^(?:\./)?gen-scripts/((?:__SKIP-)?)(\w.*)\.pl$})
{
    die "Incorrect format for script_name.";
}
my ($skip, $name) = ($1, $2);
my @command = ("perl", $script_name, @ARGV, "--name=$name");
# print +(map { "$_ " } @command), "\n";
exec(@command)
