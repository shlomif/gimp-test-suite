use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
    'module_name' => "Net::SeedServe",
    'requires' => 
    {
        'IO::All' => 0.33,
        'Test::More' => 0,
        'Time::HiRes' => 1.59,
    },
    'license' => "bsd",
    create_makefile_pl => 'traditional',
);
$build->create_build_script;

