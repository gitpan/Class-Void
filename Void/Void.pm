package Class::Void;
use strict;
use warnings;
use vars qw($VERSION); 
$VERSION = '0.01';

use overload q("")     => sub {},              # stringify to undef
            "nomethod" => sub { shift->new };  # return a new object for all other overloadable operators

sub new {
	my $class  = shift;	  
	my $scalar;
	bless \$scalar, ref $class || $class;
}

sub AUTOLOAD {
	shift->new
}

sub DESTROY {}; # autoloading DESTROY would lead to an infinite loop because it would create
                # a new object which in turn calls destroy immediately and so on
                
return q<I ain't seen nothin>

__END__

=head1 NAME

Class::Void - A class that stringifies to nothing for whatever you do with it

=head1 SYNOPSIS

  use Class::Void;
  
  my $object = Class::Void->new;
  
  $object->foo->bar("baz")->foo;
  print $object->employees("bob_smith")->age;
  print ($object->bla("test")->foo->bar->baz * 2 / 2) * $object ** 8;

=head1 DESCRIPTION

All method calls against this class or one of its instances return
another instance of the class. The behavior is the same for operations. 
Stringification returns undef. Thats about it.

=head1 "Why the hell would I need that?"

Everytime you have some class which isn't quite finished or which doesnt
provide a way to quietly do nothing, you can use this module as a stub
or a plug for the hole. This might be a web-based database maintenance
tool, where you quickly need an empty page for new entries or a leave
in a tree that needs something which doesnt die on method calls but which
doesnt take much memory, too.

I'd be very interested in other uses, so please drop me a mail if you did
something fancy with this module.

=head1 BUGS

Using this module might be a bug :-) 
Seriously, I need to think about a way to not only handle method calls
and operations but also evil people who mess around with the underlying
data structure. Of course, I could have separate sub-classes for blessed
Arrays, Hashes, etc, but first I really don't know what a blessed RegEx
should do in this context, and second if one messes around with encapsulation
one should expect to shoot oneself in the foot.

=head1 COPYRIGHT

Copyright 2000-2001 Malte Ubl <ubl@schaffhausen.de> All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
