#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("shlomif-sitting.jpg");
    plug_in_ace (1, $img, get_layer($img), 1.0, 0.69, 10, 0, 25, 0, 1);
    return { 'image_id' => $img };
}


