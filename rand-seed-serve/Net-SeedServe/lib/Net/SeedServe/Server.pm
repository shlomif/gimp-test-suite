package Net::SeedServe::Server;

use strict;
use warnings;

use Net::SeedServe;
use IO::All;
use Time::HiRes qw(usleep);

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->initialize(@_);
    return $self;
}

sub initialize
{
    my $self = shift;
    my %args = (@_);
    $self->{'status_file'} = $args{'status_file'} or
        die "Unknown status file!";

    return 0;
}

sub start
{
    my $self = shift;
    my $status_file = $self->{'status_file'};

    for(my $port = 3000; ; $port++)
    {
        unlink($status_file);
        my $fork_pid = fork();
        if (!defined($fork_pid))
        {
            die "Fork was not successful!";
        }
        if (! $fork_pid)
        {
            # The child will start the service.
            my $server = 
                Net::SeedServe->new(
                    'status_file' => $status_file,
                    'port' => $port,
                );

            eval
            {
                $server->loop();
            };
            if ($@)
            {
                exit(-1);
            }
        }
        else
        {
            # The parent will try to find the child's status
            while (! -f $status_file)
            {
                usleep(5000);
            }
            my $text = io()->file($status_file)->getline();
            if ($text eq "Status:Success\tPort:$port\tPID:$fork_pid\n")
            {
                # The game is on - the service is running and everything's OK.
                $self->{'port'} = $port;
                $self->{'server_pid'} = $fork_pid;
                return +{ 'port' => $port };
            }
            else
            {
                waitpid($fork_pid, 0);
            }
        }
    }
}

sub stop
{
    my $self = shift;

    my $pid = $self->{'server_pid'};
    kill("TERM", $pid);

    waitpid($pid, 0);
}

1;

