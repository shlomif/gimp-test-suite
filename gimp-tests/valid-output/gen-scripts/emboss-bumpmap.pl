#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("tiger_sitting.png");

    gimp_rect_select($img, 20, 30, 150, 100, CHANNEL_OP_REPLACE(), 0, 0);

    plug_in_emboss(1, $img, get_layer($img), 30, 100, 40, 0);

    return { 'image_id' => $img };
}

