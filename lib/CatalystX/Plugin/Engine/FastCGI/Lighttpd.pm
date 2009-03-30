#
# $Id$
#
package CatalystX::Plugin::Engine::FastCGI::Lighttpd;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use NEXT;

sub handle_request {
    my ( $c, @args ) = @_;

    my $env_ref = $args[1];

    if ( ( $env_ref->{SERVER_SOFTWARE} || q{} ) !~ /lighttpd/msx ) {
        $c->log->warn('Do you want to apply this really?');
    }

    if ( $c->engine ne 'Catalyst::Engine::FastCGI' ) {
        $c->log->warn('Do you want to apply this really?');
    }

    ( $env_ref->{PATH_INFO}, $env_ref->{QUERY_STRING} ) =
      ( split /\?/msx, $env_ref->{REQUEST_URI}, 2 );

    return $c->NEXT::handle_request(@args);
}

1;

__END__

=head1 NAME

CatalystX::Plugin::Engine::FastCGI::Lighttpd - enable to dispatch to the Catalyst via 404 handler.

=head1 VERSION

This document describes CatalystX::Plugin::Engine::FastCGI::Lighttpd version 0.0.1

=head1 SYNOPSIS

    # 1. in your MyApp.pm
    use Catalyst qw(+CatalystX::Engine::FastCGI::Lighttpd);
    # or
    # __PACKAGE__->setup(qw(+CatalystX::Engine::FastCGI::Lighttpd));
    
    # 2. in your lighttpd.conf
    server.error-handler-404 = "DISPATCH_TO_CATALYST"
    fastcgi.server = ( "DISPATCH_TO_CATALYST" =>
                       (( "socket" => "/path/to/myapp.socket",
                          "bin-path" => "/usr/bin/perl /path/to/myapp_fastcgi.pl",
                          "max-procs" => 5,
                          "check-local" => "disable" )))

=head1 DESCRIPTION

C::E::FastCGI could not treat with PATH_INFO and QUERY_STRING correctly.
This module enables it.

=head1 SUBROUTINES/METHODS

=head2 handle_request( $c, @args )

It rebuild PATH_INFO and QUERY_STRING from REQUEST_URI.

=head1 DIAGNOSTICS

=over

=item C<<Do you want to apply this really?>>

This module works only on fastcgi-lighttpd.

=back

=head1 CONFIGURATION AND ENVIRONMENT

CatalystX::Plugin::Engine::FastCGI::Lighttpd requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-catalystx-plugin-engine-fastcgi-lighttpd@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CatalystX-Plugin-Engine-FastCGI-Lighttpd>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
