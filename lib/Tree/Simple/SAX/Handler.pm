
package Tree::Simple::SAX::Handler;

use strict;
use warnings;

use Scalar::Util qw(blessed);

# create and load some exceptions
use Class::Throwable qw(
    Tree::Simple::SAX::InsufficientArguments
    Tree::Simple::SAX::ParseError    
    );

our $VERSION = '0.01';

use base 'XML::SAX::Base';

sub new {
    my ($_class, $root_tree) = @_;
    (blessed($root_tree) && $root_tree->isa('Tree::Simple'))
        || throw Tree::Simple::SAX::InsufficientArguments;
    my $class = ref($_class) || $_class;
    my $self = $class->SUPER::new();
    $self->{_root_tree}    = $root_tree;
    $self->{_current_tree} = $self->{_root_tree};
    return $self;
}

sub start_element {
    my ($self, $el) = @_;
    my $new_tree = $self->{_root_tree}->new();
    my $node_value = { tag_type => $el->{Name} };
    foreach my $attr_key (keys %{$el->{Attributes}}) {
        $node_value->{$el->{Attributes}->{$attr_key}->{Name}} = $el->{Attributes}->{$attr_key}->{Value};
    }
    $new_tree->setNodeValue($node_value);
    $self->{_current_tree}->addChild($new_tree);
    $self->{_current_tree} = $new_tree;
}   

sub end_element {
    my ($self) = @_;
    $self->{_current_tree} = $self->{_current_tree}->getParent();
}

sub characters {
    my ($self, $el) = @_;
    return if $el->{Data} =~ /^\s+$/;
    $self->{_current_tree}->getNodeValue()->{content} = $el->{Data};
} 

1;

__END__

=head1 NAME

Tree::Simple::SAX - An XML::SAX Handler to create Tree::Simple objects from XML

=head1 SYNOPSIS

  use Tree::Simple::SAX;
  use XML::SAX::ParserFactory;
  
  my $handler = Tree::Simple::SAX::Handler->new(Tree::Simple->new());
  
  my $p = XML::SAX::ParserFactory->parser(Handler => $handler);
  $p->parse('<xml />');  

=head1 DESCRIPTION

=head1 METHODS

=over 4

=item B<>

=back

=head1 TO DO

=head1 BUGS

None that I am aware of. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, below is the B<Devel::Cover> report on this module test suite.

=head1 SEE ALSO

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
