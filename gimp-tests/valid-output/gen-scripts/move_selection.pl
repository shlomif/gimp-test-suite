#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("tiger_sitting.png");

    gimp_rect_select($img, 20, 30, 70, 50, CHANNEL_OP_REPLACE(), 0, 0);

    gimp_ellipse_select($img, 80, 20, 50, 40, CHANNEL_OP_ADD(), 0, 0, 0);

    gimp_selection_float(get_drawable($img), 5, 13);

    return { 'image_id' => $img };
}

