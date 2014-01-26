use strict;
use warnings;

use ExtUtils::MakeMaker;
WriteMakefile(
              NAME	   => 'Bundle::GimpTest',
              VERSION_FROM => 'lib/Bundle/GimpTest.pm',
              PREREQ_PM =>
              {
                  'perl' => '5.008',
                  'strict' => 0,
                  'warnings' => 0,
              },
             );
