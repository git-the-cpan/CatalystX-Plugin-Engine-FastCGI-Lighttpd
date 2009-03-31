#!/usr/bin/env perl
#
# $Id$
#
use strict;
use warnings;
use version; our $VERSION = qv('0.0.2');

use blib;
use Test::Base tests => 1;

TODO: {
    local $TODO = 'It is difficult to write test using lighttpd.';
    pass('[FIXME] Please write test.');
}
