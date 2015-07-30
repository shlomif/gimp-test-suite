#!/usr/bin/perl -w

use strict;
use warnings;

use constant TRANSFORM_FORWARD => 0;
use constant INTERPOLATION_CUBIC => 2;
# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("tiger_sitting.png");

    gimp_rect_select($img, 20, 30, 70, 50, CHANNEL_OP_REPLACE(), 0, 0);

    gimp_drawable_transform_perspective (get_layer($img),
        10, 10, 100, 20,
        50, 80, 130, 60,
        TRANSFORM_FORWARD(),
        INTERPOLATION_CUBIC(),
        1,
        3,
        0);

    return { 'image_id' => $img };
}

