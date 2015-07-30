#!/usr/bin/perl -w

use strict;
use warnings;

# This is done to execute the test wrapper.
require GimpTest::Run;

# This function will be modified from script to script.
sub gen_image
{
    gimp_context_push();

    my $img = gimp_image_new (256, 256, RGB());

    my $layer =
        gimp_layer_new ($img, 256, 256, RGBA_IMAGE(),
            "mylayer", 100, NORMAL_MODE());

    gimp_image_add_layer($img, $layer, -1);

    gimp_context_set_foreground ([0,0,0]);

    gimp_drawable_fill ($layer, FOREGROUND_FILL());

    gimp_rect_select ($img, 20, 30, 70, 50, CHANNEL_OP_REPLACE(), 0, 0);

    gimp_context_set_foreground ([255,0,0]);

    gimp_edit_fill ($layer, FOREGROUND_FILL());

    gimp_selection_none ($img);

    my $channel = gimp_channel_new_from_component ($img, RED_CHANNEL(), "selection");

    gimp_image_add_channel ($img, $channel, -1);

    gimp_context_set_foreground ([0,0,0]);

    gimp_drawable_fill ($layer, FOREGROUND_FILL());

    gimp_selection_load ($channel);

    gimp_context_set_foreground ([0,255,0]);

    gimp_edit_fill ($layer, FOREGROUND_FILL());

    gimp_context_pop();

    return { 'image_id' => $img };
}

