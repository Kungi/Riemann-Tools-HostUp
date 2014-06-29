#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Riemann::HostUp' ) || print "Bail out!\n";
}

diag( "Testing Riemann::HostUp $Riemann::HostUp::VERSION, Perl $], $^X" );
