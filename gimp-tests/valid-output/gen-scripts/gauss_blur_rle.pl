#!/usr/bin/perl -w

use strict;
use warnings;

use Gimp ":auto";

use Cwd;
use Digest::MD5;
use YAML (qw(DumpFile LoadFile));

Gimp::init();

sub get_drawable
{
    my $img = shift;
    return (gimp_image_get_layers($img))[0];
}

my $output_fn = getcwd() . "/temp/output-images/gauss_blur_rle.bmp";

my $input_fn = getcwd() . "/input-images/tiger_sitting.png";
my $img = gimp_file_load(1, $input_fn, $input_fn);

plug_in_gauss(1, $img, get_drawable($img), 5.0, 10.0, 1);
gimp_image_flatten($img);
gimp_file_save(1, $img, get_drawable($img), $output_fn, $output_fn);
gimp_image_delete($img);

my $do_what = shift(@ARGV);
my $signature = +{};
$signature->{'length'} = (-s $output_fn);
$signature->{'hash_functions'} = ["md5"];
{
    local *I;
    open I, "<", $output_fn;
    my $md5 = Digest::MD5->new();
    $signature->{'hash_values'} = +{ 'md5' => $md5->addfile(*I)->hexdigest() };
    close(I);
}
my $sign_fn = "output-sigs/gauss_blur_rle.yml";
if ($do_what eq "init")
{
    DumpFile($sign_fn, $signature);
}
elsif ($do_what eq "check")
{
    my ($expected_sign) = LoadFile($sign_fn);
    if ($expected_sign->{'length'} != $signature->{'length'})
    {
        die "Length Mismatch!";
    }
    foreach my $func (@{$signature->{'hash_functions'}})
    {
        if ($expected_sign->{'hash_values'}->{$func} ne
            $signature->{'hash_values'}->{$func})
        {
            die "Hash Value Mismatch for \"$func\"!";
        }
    }
}
print "Success!\n";

unlink($output_fn);

