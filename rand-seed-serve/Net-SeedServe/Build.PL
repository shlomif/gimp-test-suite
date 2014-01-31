use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
    'module_name' => "Net::SeedServe",
    configure_requires => { 'Module::Build' => '0.39', },
    'requires' =>
    {
        'perl' => '5.008',
        'IO::All' => 0.33,
        'Test::More' => 0,
        'Time::HiRes' => 1.59,
    },
    'license' => 'mit',
    create_makefile_pl => 'traditional',
);
$build->create_build_script;

