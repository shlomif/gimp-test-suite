#!/usr/bin/perl -w

# This is a meta script that checks that the uncompressed contents of
# a JPEG file are the same any-time it is loaded.

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    my $img = load_input_file("shlomif-sitting.jpg");

    return { 'image_id' => $img };
}

