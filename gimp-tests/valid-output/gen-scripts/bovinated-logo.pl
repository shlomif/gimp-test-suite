#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    init_seeds([5000, 38, 1090, 20001, 805, 27]);
    my $img = load_input_file("text-becker-the-gimp.png");

    script_fu_bovinated_logo_alpha(RUN_NONINTERACTIVE(), $img, get_layer($img),
        16, 4, [0,255,255],
        );

    return { 'image_id' => $img };
}

