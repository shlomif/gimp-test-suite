#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("tiger_sitting.png");

    plug_in_gauss(1, $img, get_drawable($img), 5.0, 10.0, 1);

    return { 'image_id' => $img };
}

