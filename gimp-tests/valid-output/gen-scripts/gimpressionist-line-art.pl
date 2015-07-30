#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    init_seeds([50000]);
    my $img = load_input_file("shlomif-sitting.jpg");

    plug_in_gimpressionist(RUN_NONINTERACTIVE(),
        $img, get_layer($img), "Line-art"
        );

    return { 'image_id' => $img };
}

