package Net::SeedServe;

use 5.008;
use strict;
use warnings;

use IO::Socket::INET;
use IO::All;

our $VERSION = '0.1.0_00';

sub new
{
    my $class = shift;
    my $self = +{};
    bless $self, $class;
    $self->initialize(@_);
    return $self;
}

sub initialize
{
    my $self = shift;

    my %args = (@_);

    my $port = $args{'port'} or
        die "Port not specified!";
    
    $self->{'port'} = $port;

    $self->{'status_file'} = $args{'status_file'} or
        die "Success file not specified";

    return 0;
}

sub set_status_file
{
    my $self = shift;
    my $string = shift;
    
    io()->file($self->{'status_file'})->print("$string\n");
}

sub loop
{
    my $self = shift;

    my $serving_socket;

    $serving_socket = 
        IO::Socket::INET->new(
            Listen    => 5,
            LocalAddr => 'localhost',
            LocalPort => $self->{'port'},
            Proto     => 'tcp'
        );
    if (!defined($serving_socket))
    {
        $self->set_status_file("Status:Error");
        die $@;
    }

    $self->set_status_file(
        "Status:Success\tPort:" . $self->{'port'} . "\tPID:$$"
        );

    my @queue;
    my $next_seed;

    my $clear = sub {
        @queue = ();
        $next_seed = 1;
    };

    $clear->();

    while (my $conn = $serving_socket->accept())
    {
        my $request = $conn->getline();
        my $response;
        if ($request =~ /^FETCH/)
        {
            my $seed;
            if ($seed = shift(@queue))
            {
                $response = $seed;
                $next_seed = $seed+1;
            }
            else
            {
                $response = $next_seed++;
            }
        }
        elsif ($request =~ /^CLEAR/)
        {
            $clear->();
            $response = "OK";
        }
        elsif ($request =~ /^ENQUEUE ((?:\d+,)+)/)
        {
            my $nums = $1;
            $nums =~ s{,$}{};
            push @queue, split(/,/, $nums);
            $response = "OK";
        }
        else
        {
            $response = "ERROR";
        }
        $conn->print("$response\n");
    }
}

1;
__END__

=head1 NAME

Net::SeedServe - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Net::SeedServe;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Net::SeedServe, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 AUTHOR

Shlomi Fish, E<lt>shlomif@iglu.org.ilE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Shlomi Fish

This library is free software, you can redistribute and/or modify and/or
use it under the terms of the MIT X11 license.

=cut
