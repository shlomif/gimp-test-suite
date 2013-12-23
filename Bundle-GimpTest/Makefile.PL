use strict;
use warnings;

use ExtUtils::MakeMaker;
WriteMakefile(
              NAME	   => 'Bundle::GimpTest',
              VERSION_FROM => 'GimpTest.pm',
              'dist'       => {
                               COMPRESS => 'gzip -9f',
                               SUFFIX   => '.gz',
                               DIST_DEFAULT => 'all tardist',
                              },
             );
