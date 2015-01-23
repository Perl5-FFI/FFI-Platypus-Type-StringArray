# FFI::Platypus::Type::StringArray

Platypus custom type for arrays of strings

# SYNOPSIS

In your C code:

    void
    takes_string_array(const char **array)
    {
      ...
    }

In your [Platypus::FFI](https://metacpan.org/pod/Platypus::FFI) code:

    use FFI::Platypus::Declare
      'void',
      [ '::StringArray' => 'string_array' ];
    
    attach takes_string_array => [string_array] => void;
    
    my @list = qw( foo bar baz );
    
    takes_string_array \@list;

# DESCRIPTION

This module provides a [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) custom type for arrays of strings.
The array is always NULL terminated.  It is not (yet) supported as a return type.

# SEE ALSO

- [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus)
- [FFI::Platypus::Type::StringPointer](https://metacpan.org/pod/FFI::Platypus::Type::StringPointer)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
