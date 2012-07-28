package Bundle::QuadPres

$VERSION = '0.2.0';

1;

__END__

=head1 NAME

Bundle::GimpTest - A bundle to install external CPAN modules used by GIMP's
Testing Framework.

=head1 SYNOPSIS

Perl one liner using CPAN.pm:

  perl -MCPAN -e 'install Bundle::GimpTest'

Use of CPAN.pm in interactive mode:

  $> perl -MCPAN -e shell
  cpan> install Bundle::GimpTest
  cpan> quit

Just like the manual installation of perl modules, the user may
need root access during this process to insure write permission 
is allowed within the intstallation directory.


=head1 CONTENTS

Digest::MD5

Getopt::Long

IO::All

Net::SeedServe

String::ShellQuote

Time::HiRes

YAML

=head1 DESCRIPTION

This bundle installs modules needed by the Gimp Testing Framework:

http://gimp-test.berlios.de/

=head1 AUTHOR

Shlomi Fish E<lt>shlomif@iglu.org.ilE<gt>

=cut

