#!/usr/bin/perl -w

use strict;
use warnings;

use Net::SeedServe::Server;
use String::ShellQuote;

use constant GIMP_VER => "2.3";

sub find_grand_seedserve_lib
{
    my @dirs = (qw(/usr/lib /usr/local/lib), 
        split(/:/, $ENV{'LD_LIBRARY_PATH'}));
    foreach my $d (@dirs)
    {
        my $full_path = "$d/libgrand_seedserve.so";
        if (-f $full_path)
        {
            return $full_path;
        }
    }
    die "Could not find libgrand_seedserve.so!";
}

my $seed_server_status_file = "temp/server-status.txt";
# First of all - start the service.
my $seed_server =
    Net::SeedServe::Server->new(
        'status_file' => $seed_server_status_file,
    );

my $seed_server_port = $seed_server->start()->{'port'};

my $grand_ss_path = find_grand_seedserve_lib();

# Start the gimp
{
    local $ENV{'SEEDSERVE_PORT'} = $seed_server_port;
    local $ENV{'LD_PRELOAD'} = $grand_ss_path;
    system("gimp-".GIMP_VER(). " " . 
        shell_quote("--batch=(extension-perl-server RUN-INTERACTIVE 0 0)") . 
        " &"
        );
}

print STDERR "Type <Return> to exit.\n";
my $line = <STDIN>;

END
{
    # Cleanup.
    $seed_server->stop();
}
