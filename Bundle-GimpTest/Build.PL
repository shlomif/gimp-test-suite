use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
    module_name	   => 'Bundle::GimpTest',
    configure_requires =>
    {
        'Module::Build' => '0.36',
    },
    VERSION_FROM => 'lib/Bundle/GimpTest.pm',
    requires =>
    {
        'perl' => '5.008',
        'strict' => 0,
        'warnings' => 0,
    },
    license => "mit",
    meta_merge =>
    {
        resources =>
        {
            repository => "https://bitbucket.org/shlomif/gimp-test-suite",
        },
    },
);

$build->create_build_script;
