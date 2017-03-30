package Alien::Libarchive;

use strict;
use warnings;
use Alien::Libarchive3;
use Path::Tiny qw( path );
use Text::ParseWords qw( shellwords );

# ABSTRACT: Legacy alien for libarchive
# VERSION

=head1 SYNOPSIS

 use Alien::Libarchive3;

=head1 DESCRIPTION

This module provides a legacy interface used by
some older versions of L<Archive::Libarchive::XS>
and L<Archive::Libarchive::FFI>.  Please use the
new interface instead: L<Alien::Libarchive3>.

=head1 SEE ALSO

L<Alien::Libarchive3>

=cut

sub new
{
  my($class) = @_;
  bless {}, $class;
}

sub cflags
{
  wantarray
    ? shellwords(Alien::Libarchive3->cflags)
    : Alien::Libarchive3->cflags;
}

sub libs
{
  wantarray
    ? shellwords(Alien::Libarchive3->libs)
    : Alien::Libarchive3->libs;
}

sub dlls
{
  my @libs = Alien::Libarchive3->dynamic_libs;
  wantarray ? @libs : $libs[0];
}

sub version
{
  Alien::Libarchive3->version;
}

sub install_type
{
  Alien::Libarchive3->install_type;
}

sub pkg_config_dir
{
  path(Alien::Libarchive3->dist_dir, 'lib', 'pkgconfig')->stringify;
}

sub pkg_config_name
{
  'libarchive';
}

sub _macro_list
{
  require Config;
  require File::Temp;
  require File::Spec;

  my $alien = Alien::Libarchive->new;
  my $cc = "$Config::Config{ccname} $Config::Config{ccflags} " . $alien->cflags;

  my $fn = File::Spec->catfile(File::Temp::tempdir( CLEANUP => 1 ), "test.c");

  do {
    open my $fh, '>', $fn;
    print $fh "#include <archive.h>\n";
    print $fh "#include <archive_entry.h>\n";
    close $fh;
  };

  my @list;
  my $cmd = "$cc -E -dM $fn";
  foreach my $line (`$cmd`)
  {
    if($line =~ /^#define ((AE|ARCHIVE)_\S+)/)
    {
      push @list, $1;
    }
  }
  sort @list;
}

1;
