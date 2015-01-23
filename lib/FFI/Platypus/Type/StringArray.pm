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
The array is always NULL terminated.  It is not (yet) supported as a return type.

=cut

use constant _incantation =>
  $^O eq 'MSWin32' && $Config::Config{archname} =~ /MSWin32-x64/
  ? 'Q'
  : 'L!';

my @stack;

sub perl_to_native
{
  my $count = scalar @{ $_[0] };
  my $pointers = pack(('P' x $count)._incantation, @{ $_[0] }, 0);
  my $array_pointer = unpack _incantation, pack 'P', $pointers;
  push @stack, [ \$_[0], \$pointers ];
  $array_pointer;
}

sub perl_to_native_post
{
  pop @stack;
  ();
}

sub ffi_custom_type_api_1
{
  my(undef, $count, $default) = @_;
  
  my $config = {
    native_type => 'opaque',
    perl_to_native => \&perl_to_native,
    perl_to_native_post => \&perl_to_native_post,
  };

  if(defined $count)
  {
    $config->{perl_to_native} = sub {
      my @list;
      my $incantation = '';
      
      foreach my $item (@{ $_[0] })
      {
        if(defined $item)
        {
          push @list, $item;
          $incantation .= 'P';
        }
        elsif(defined $default)
        {
          push @list, $default;
          $incantation .= 'P';
        }
        else
        {
          push @list, 0;
          $incantation .= _incantation;
        }
      }
      
      push @list, 0;
      $incantation .= _incantation;
      my $pointers = pack $incantation, @list;
      my $array_pointer = unpack _incantation, pack 'P', $pointers;
      push @stack, [ \@list, $pointers ];
      $array_pointer;
    };
  }
  
  $config;
}

1;


=head1 SEE ALSO

=over 4

=item L<FFI::Platypus>

=item L<FFI::Platypus::Type::StringPointer>

=back

=cut
