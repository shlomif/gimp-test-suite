#!/usr/bin/perl -w

use strict;
use warnings;

use IO::All;
use Net::SeedServe::Server;

# First of all - start the service.
my $server =
    Net::SeedServe::Server->new(
        'status_file' => "temp/server-status.txt",
    );

my $ret = $server->start();
my $port = $ret->{'port'};
print "Port == $port\n";

my $line = <STDIN>;

$server->stop();

