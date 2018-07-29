# FFI::Platypus::Type::StringArray

Platypus custom type for arrays of strings

# SYNOPSIS

In your C code:

    void
    takes_string_array(const char **array)
    {
      ...
    }
    
    void
    takes_fixed_string_array(const char *array[5])
    {
      ...
    }

In your [Platypus::FFI](https://metacpan.org/pod/Platypus::FFI) code:

    use FFI::Platypus;

    my $ffi = FFI::Platypus->new;
    $ffi->load_custom_type('::StringArray' => 'string_array');
    $ffi->load_custom_type('::StringArray' => 'string_5' => 5);
    
    $ffi->attach(takes_string_array => ['string_array'] => 'void');
    $ffi->attach(takes_fixed_string_array => ['string_5'] => 'void');
    
    my @list = qw( foo bar baz );
    
    takes_string_array(\@list);
    takes_fixed_string_array([qw( s1 s2 s3 s4 s5 )]);

# DESCRIPTION

This module provides a [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) custom type for arrays of
strings. The array is always NULL terminated.  Return types are supported
for fixed length arrays.  It is not (yet) supported for variable length
return types.

This custom type takes two optional arguments.  The first is the size of
arrays and the second is a default value to fill in any values that
aren't provided when the function is called.  If not default is provided
then `NULL` will be passed in for those values.

# SUPPORT

If something does not work the way you think it should, or if you have a
feature request, please open an issue on this project's GitHub Issue
tracker:

[https://github.com/plicease/FFI-Platypus-Type-StringArray/issues](https://github.com/plicease/FFI-Platypus-Type-StringArray/issues)

# CONTRIBUTING

If you have implemented a new feature or fixed a bug then you may make a
pull request on this project's GitHub repository:

[https://github.com/plicease/FFI-Platypus-Type-StringArray/pulls](https://github.com/plicease/FFI-Platypus-Type-StringArray/pulls)

This project's GitHub issue tracker listed above is not Write-Only.  If
you want to contribute then feel free to browse through the existing
issues and see if there is something you feel you might be good at and
take a whack at the problem.  I frequently open issues myself that I
hope will be accomplished by someone in the future but do not have time
to immediately implement myself.

Another good area to help out in is documentation.  I try to make sure
that there is good document coverage, that is there should be
documentation describing all the public features and warnings about
common pitfalls, but an outsider's or alternate view point on such
things would be welcome; if you see something confusing or lacks
sufficient detail I encourage documentation only pull requests to
improve things.

# SEE ALSO

- [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus)
- [FFI::Platypus::Type::StringPointer](https://metacpan.org/pod/FFI::Platypus::Type::StringPointer)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
