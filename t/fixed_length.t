use strict;
use warnings;
use Test::More;
use FFI::CheckLib;
use FFI::Platypus::Declare
  'void', 'int', 'string',
  [ '::StringArray' => 'string_5_hey',   5, "hey" ],
  [ '::StringArray' => 'string_5_undef', 5, undef ];

my $libtest = find_lib lib => 'test', libpath => 'libtest';
plan skip_all => 'test requires a compiler'
  unless $libtest;

plan tests => 6;

lib $libtest;

attach [get_string_from_array => 'a1'] => [string_5_hey,  int] => string;
attach [get_string_from_array => 'a2'] => [string_5_undef,int] => string;


my @list = ( 'foo', 'bar', 'baz', undef, 'five', 'six' );

is a1(\@list, 0), 'foo', 'a1(0) = foo';
is a1(\@list, 1), 'bar', 'a1(0) = bar';
is a1(\@list, 2), 'baz', 'a1(0) = baz';
is a1(\@list, 3), undef, 'a1(0) = undef';
is a1(\@list, 4), 'five', 'a1(0) = five';
is a1(\@list, 5), undef, 'a1(0) = undef';
