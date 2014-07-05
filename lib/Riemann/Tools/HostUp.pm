package Riemann::Tools::HostUp;

require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(ping_all_hosts); # symbols to export on request

use 5.20.0;
use strict;
use warnings FATAL => 'all';

use experimental 'signatures';
use feature 'say';

use Net::Ping;
use Riemann::Client;


=head1 NAME

Riemann::HostUp - The great new Riemann::HostUp!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Riemann::HostUp;

    my $foo = Riemann::HostUp->new();
    ...

=cut

sub ping_host ($host, $ping_type) {
    my $p = Net::Ping->new($ping_type);
    my $ping_ok = $p->ping($host);
    $p->close;
    return $ping_ok;
}

sub send_result_to_riemann ($conf, $host, $ping_ok) {
    my $r = Riemann::Client->new(
        host => $conf->{riemann_host},
        port => $conf->{riemann_port},
    );

    $r->send({
        host    => $host,
        service => 'up',
        state   => $ping_ok ? 'ok' : 'critical',
        metric  => $ping_ok ? 1 : 0,
        description => "Used ICMP ping",
    });
}

sub ping_all_hosts ($conf, $ping_type, $verbose, @hosts) {
    foreach my $host (@hosts) {

        my $ping_ok = ping_host($host, $ping_type);

        say "$host is up" if $verbose && $ping_ok;
        say "$host is down" if $verbose && !$ping_ok;

        send_result_to_riemann($conf,
                               $host,
                               $ping_ok);
    }
}

=head1 AUTHOR

Andreas 'Kungi' Klein, C<< <perl at kungi.org> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Riemann::HostUp

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Riemann-HostUp>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Riemann-HostUp>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Riemann-HostUp>

=item * Search CPAN

L<http://search.cpan.org/dist/Riemann-HostUp/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Andreas 'Kungi' Klein.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Riemann::HostUp
