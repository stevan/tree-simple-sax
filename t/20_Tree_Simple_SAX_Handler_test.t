#!/usr/bin/perl

use strict;
use warnings;

BEGIN {
    use_ok('Tree::Simple::SAX::Handler');
    use_ok('Tree::Simple');    
    use_ok('XML::SAX::ParserFactory');
}

my $root = Tree::Simple->new(Tree::Simple->ROOT);
isa_ok($root, 'Tree::Simple');  
  
my $handler = Tree::Simple::SAX::Handler->new();
isa_ok($handler, 'Tree::Simple::SAX::Handler');

my $p = XML::SAX::ParserFactory->parser(Handler => $handler);
$p->parse('<xml />');

$root->traverse(
    my $t = shift;
    my $node = $t->getNodeValue();
    print(("\t" x $t->getDepth()) . "(" . (join ", " => map { "$_ => '" . $node->{$_} . "'" } keys %{$node}) . ")\n");
);

