#!/usr/bin/perl -w

use strict;
use warnings;

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 1;

use IO::All;
use Cwd;

use Net::SeedServe::Server;

# First of all - start the service.
my $server =
    Net::SeedServe::Server->new(
        'status_file' => "temp/server-status.txt",
    );

my $ret = $server->start();
my $port = $ret->{'port'};

$ENV{'SEEDSERVE_PORT'} = $port;

$ENV{'LD_PRELOAD'} = getcwd()."/.libs/libgrand_seedserve.so";

# The eval { } is to trap exceptions, so we can safely stop the server at 
# cleanup.
eval {
    $server->clear();
    $server->enqueue([24]);
    
    my $result = `./grand-test-experiment`;
    my $expected = io()->file("grand-test-output.good.txt")->slurp();
    # TEST
    is ($result, $expected, "Comparing Output of Seed Serve");
};

$server->stop();

if ($@)
{
    die $@;
}

