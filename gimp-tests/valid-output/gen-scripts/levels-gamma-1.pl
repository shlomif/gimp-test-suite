#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("shlomif-sitting.jpg");

    gimp_levels (get_layer($img), HISTOGRAM_VALUE(), 0, 255, 1.5, 0, 255);

    return { 'image_id' => $img };
}


