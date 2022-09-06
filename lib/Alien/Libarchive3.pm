package Alien::Libarchive3;

use strict;
use warnings;
use base qw( Alien::Base );

# ABSTRACT: Find or install libarchive version 3.x or better
# VERSION
# ALIEN SYNOPSIS
# ALIEN DESCRIPTION

=pod

The older L<Alien::Libarchive> exists as a compatibility layer over this module.

=head1 CAVEATS

On some older operating systems some of the dependencies may not build, L<Alien::Nettle>
does not build correctly with older versions of OpenSSL.  If you do not need the encryption
features provided by L<Alien::Nettle> and C<nettle>, then you can skip it when you install
this module:

 $ env ALIEN_LIBARCHIVE_DEPS=Alien::xz,Alien::LZO,Alien::Libbz2,Alien::Libxml2 cpanm Alien::Libarchive3

=cut

# ALIEN SEE ALSO

1;
