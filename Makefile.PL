use 5.20.0;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Riemann::Tools::HostUp',
    AUTHOR           => q{Andreas 'Kungi' Klein <perl@kungi.org>},
    VERSION_FROM     => 'lib/Riemann/Tools/HostUp.pm',
    ABSTRACT_FROM    => 'lib/Riemann/Tools/HostUp.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.20.0,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },

    "EXE_FILES" => [
        "bin/riemann-host-up"
    ],

    BUILD_REQUIRES => {
        'Test::More'                 => 0,
        'Net::Ping'                  => 0,
        'Riemann::Client'            => 0,
        'IO::Async::Timer::Periodic' => 0,
        'IO::Async::Loop'            => 0,
        'Pod::Usage'                 => 0,
    },
    PREREQ_PM => {
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Riemann-Tools-HostUp-*' },
);
