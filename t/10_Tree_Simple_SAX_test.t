#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

BEGIN { 
    use_ok('Tree::Simple::SAX');
    use_ok('Tree::Simple::SAX::Handler');    
}