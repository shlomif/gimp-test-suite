use strict;
use warnings;

use Gimp ":auto";

use Cwd;
use Digest::MD5;
use YAML (qw(DumpFile LoadFile));
use Getopt::Long;

my $mode = undef;
my $test_name = undef;
my %options = ();

my $cmd_line_ok = 
    GetOptions(
        "mode=s" => \$mode,
        "name=s" => \$test_name,
        "options=s" => \%options,
    );

if (!$cmd_line_ok)
{
    die "Incorrect options passed.";
}
if (!defined($mode))
{
    die "Mode not specified.";
}
if (!(($mode eq "init") || ($mode eq "check") || ($mode eq "gen")))
{
    die "Unknown mode \"$mode\".";
}
if (!defined($test_name))
{
    die "Test name not specified.";
}

Gimp::init();

sub get_drawable
{
    my $img = shift;
    return (gimp_image_get_layers($img))[0];
}

sub load_input_file
{
    my $filename = shift;
    my $input_fn = getcwd() . "/input-images/$filename";
    return gimp_file_load(1, ($input_fn) x 2);
}

my $output_fn = getcwd() . "/temp/output-images/$test_name.bmp";
my $img = main::gen_image()->{'image_id'};
gimp_image_flatten($img);
gimp_file_save(1, $img, get_drawable($img), $output_fn, $output_fn);
gimp_image_delete($img);

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
my $sign_fn = "output-sigs/$test_name.yml";
if ($mode eq "init")
{
    DumpFile($sign_fn, $signature);
}
elsif ($mode eq "check")
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

if ($mode eq "gen")
{
    # Do nothing
}
else
{
    unlink($output_fn);
}

1;

