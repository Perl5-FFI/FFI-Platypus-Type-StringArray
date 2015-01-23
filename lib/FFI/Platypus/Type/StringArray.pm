package FFI::Platypus::Type::StringArray;

use strict;
use warnings;

# ABSTRACT: Platypus custom type for arrays of strings
# VERSION

=head1 SYNOPSIS

In your C code:

 void
 takes_string_array(const char **array)
 {
   ...
 }

In your L<Platypus::FFI> code:

 use FFI::Platypus::Declare
   'void',
   [ '::StringArray' => 'string_array' ];
 
 attach takes_string_array => [string_array] => void;
 
 my @list = qw( foo bar baz );
 
 takes_string_array \@list;

=head1 DESCRIPTION

This module provides a L<FFI::Platypus> custom type for arrays of strings.
It is not (yet) supported as a return type.

=cut

use constant _incantation =>
  $^O eq 'MSWin32' && $Config::Config{archname} =~ /MSWin32-x64/
  ? 'Q'
  : 'L!';

my @stack;

sub ffi_custom_type_api_1
{
  #my($ffi, $count) = @_;
  
  return {
  
    native_type => 'opaque',
    
    perl_to_native => sub {
      my $argc = scalar @{ $_[0] };
      my @c_strings = map { "$_\0" } @{ $_[0] };
      my $ptrs = pack 'P' x $argc, @c_strings, 0;
      my $argv = unpack _incantation, pack 'P', $ptrs;
      push @stack, [ \@c_strings, \$ptrs ];
      $argv;
    },
    
    perl_to_native_post => sub {
      pop @stack;
      ();
    },
  
  };
}

1;


=head1 SEE ALSO

=over 4

=item L<FFI::Platypus>

=item L<FFI::Platypus::Type::StringPointer>

=back

=cut
