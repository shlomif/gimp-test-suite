#!/usr/bin/perl -w

use strict;
use warnings;

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 20;

use IO::All;
# TEST
BEGIN { use_ok('Net::SeedServe') };

use Net::SeedServe::Server;

# First of all - start the service.
my $server =
    Net::SeedServe::Server->new(
        'status_file' => "temp/server-status.txt",
    );

my $ret = $server->start();
my $port = $ret->{'port'};

$ENV{'SEEDSERVE_PORT'} = $port;

sub get_seed
{
    my $text = `./seedserve-run`;
    return $text;
}

# The eval { } is to trap exceptions, so we can safely stop the server at 
# cleanup.
eval {
    # Phase 1 : Test regular initiatory seeds, with a possible clear.
    {
        # TEST
        is (get_seed(), "1\n");
    }
    {
        # TEST
        is (get_seed(), "2\n");
    }
    {
        # TEST
        is (get_seed(), "3\n");
    }
    {
        # TEST
        ok(!$server->clear());
    }
    {
        # TEST
        is (get_seed(), "1\n");
    }
    {
        # TEST
        is (get_seed(), "2\n");
    }
    # Phase 2 - test the ENQUEUE method.
    {
        # TEST
        ok (!$server->enqueue([5]), "Enqueuing 5");
    }
    {
        # TEST
        is (get_seed(), "5\n");
    }
    {
        # TEST
        is (get_seed(), "6\n");
    }
    {
        # TEST
        ok(!$server->enqueue([10,200,398]), "Enqueuing...");
    }
    {
        # TEST
        is (get_seed(), "10\n");
    }
    {
        # TEST
        is (get_seed(), "200\n");
    }
    {
        # TEST
        is (get_seed(), "398\n");
    }
    {
        # TEST
        is (get_seed(), "399\n");
    }
    {
        # TEST
        ok(!$server->enqueue([24,39]));
    }
    {
        # TEST
        is (get_seed(), "24\n");
    }
    {
        # TEST
        ok(!$server->enqueue([805]));
    }
    {
        # TEST
        is (get_seed(), "39\n");
    }
    {
        # TEST
        is (get_seed(), "805\n");
    }
};

$server->stop();

if ($@)
{
    die $@;
}
