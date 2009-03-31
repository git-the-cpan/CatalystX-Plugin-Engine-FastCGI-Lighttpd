#! /usr/bin/env perl
#
# $Id$
#
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.2');

BEGIN {
    use File::Spec;
    use FindBin qw($Bin);
    chdir File::Spec->catdir( $Bin, q{..} );
}
use Test::Base;

if ( $ENV{TEST_KWALITEE} || $ENV{TEST_ALL} || !$ENV{HARNESS_ACTIVE} ) {
    eval {
        require Test::Kwalitee;
        Test::Kwalitee->import;
        1;
      }
      or do {
        plan skip_all => 'Test::Kwalitee required for testing Kwalitee';
      };
}
else {
    plan skip_all => 'set TEST_KWALITEE for testing Kwalitee';
}
