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
        'status_file' => "TEMP/server-status.txt",
    );

my $ret = $server->start();
my $port = $ret->{'port'};

# The eval { } is to trap exceptions, so we can safely stop the server at 
# cleanup.
eval {
    # Phase 1 : Test regular initiatory seeds, with a possible clear.
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "1\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "2\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "3\n");
    }
    {
        # TEST
        ok(!$server->clear());
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "1\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "2\n");
    }
    # Phase 2 - test the ENQUEUE method.
    {
        # TEST
        ok (!$server->enqueue([5]), "Enqueuing 5");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "5\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "6\n");
    }
    {
        # TEST
        ok(!$server->enqueue([10,200,398]), "Enqueuing...");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "10\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "200\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "398\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "399\n");
    }
    {
        # TEST
        ok(!$server->enqueue([24,39]));
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "24\n");
    }
    {
        # TEST
        ok(!$server->enqueue([805]));
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "39\n");
    }
    {
        my $conn = io("localhost:$port");
        $conn->print("FETCH\n");
        # TEST
        is ($conn->getline(), "805\n");
    }
};

$server->stop();

if ($@)
{
    die $@;
}
