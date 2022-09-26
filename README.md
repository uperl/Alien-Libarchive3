# Alien::Libarchive3 ![linux](https://github.com/uperl/Alien-Libarchive3/workflows/linux/badge.svg) ![macos](https://github.com/uperl/Alien-Libarchive3/workflows/macos/badge.svg) ![windows](https://github.com/uperl/Alien-Libarchive3/workflows/windows/badge.svg) ![cygwin](https://github.com/uperl/Alien-Libarchive3/workflows/cygwin/badge.svg) ![msys2-mingw](https://github.com/uperl/Alien-Libarchive3/workflows/msys2-mingw/badge.svg)

Find or install libarchive version 3.x or better

# SYNOPSIS

In your Makefile.PL:

```perl
use ExtUtils::MakeMaker;
use Alien::Base::Wrapper ();

WriteMakefile(
  Alien::Base::Wrapper->new('Alien::Libarchive3')->mm_args2(
    # MakeMaker args
    NAME => 'My::XS',
    ...
  ),
);
```

In your Build.PL:

```perl
use Module::Build;
use Alien::Base::Wrapper qw( Alien::Libarchive3 !export );

my $builder = Module::Build->new(
  ...
  configure_requires => {
    'Alien::Libarchive3' => '0',
    ...
  },
  Alien::Base::Wrapper->mb_args,
  ...
);

$build->create_build_script;
```

In your script or module:

```perl
use Alien::Libarchive3;
use Env qw( @PATH );

unshift @PATH, Alien::Libarchive3->bin_dir;
```

In your [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) script or module:

```perl
use FFI::Platypus;
use Alien::Libarchive3;

my $ffi = FFI::Platypus->new(
  lib => [ Alien::Libarchive3->dynamic_libs ],
);
```

# DESCRIPTION

This distribution provides libarchive so that it can be used by other
Perl distributions that are on CPAN.  It does this by first trying to
detect an existing install of libarchive on your system.  If found it
will use that.  If it cannot be found, the source code will be downloaded
from the internet and it will be installed in a private share location
for the use of other modules.

The older [Alien::Libarchive](https://metacpan.org/pod/Alien::Libarchive) exists as a compatibility layer over this module.

# CAVEATS

On some older operating systems some of the dependencies may not build, [Alien::Nettle](https://metacpan.org/pod/Alien::Nettle)
does not build correctly with older versions of OpenSSL.  If you do not need the encryption
features provided by [Alien::Nettle](https://metacpan.org/pod/Alien::Nettle) and `nettle`, then you can skip it when you install
this module:

```
$ env ALIEN_LIBARCHIVE_DEPS=Alien::xz,Alien::LZO,Alien::Libbz2,Alien::Libxml2 cpanm Alien::Libarchive3
```

# SEE ALSO

[Alien](https://metacpan.org/pod/Alien), [Alien::Base](https://metacpan.org/pod/Alien::Base), [Alien::Build::Manual::AlienUser](https://metacpan.org/pod/Alien::Build::Manual::AlienUser)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017-2022 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
