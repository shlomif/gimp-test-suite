use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::SeedServe',
    VERSION_FROM      => 'lib/Net/SeedServe.pm', # finds $VERSION
    PREREQ_PM         =>
    {
        'IO::All' => 0.33,
        'Test::More' => 0,
        'Time::HiRes' => 1.59,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Net/SeedServe.pm', # retrieve abstract from module
       AUTHOR         => 'Shlomi Fish <shlomi@mandrakesoft.com>') : ()),
);
