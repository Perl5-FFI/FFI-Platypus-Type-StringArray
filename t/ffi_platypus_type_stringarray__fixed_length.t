use strict;
use warnings;
use Test::More;
use FFI::CheckLib;
use FFI::Platypus;

my $ffi = FFI::Platypus->new;

$ffi->load_custom_type('::StringArray' => 'string_5_hey' => 5, "hey");
$ffi->load_custom_type('::StringArray' => 'string_5_undef' => 5, undef);

my $libtest = find_lib lib => 'test', libpath => 'libtest';
plan skip_all => 'test requires a compiler'
  unless $libtest;

$ffi->lib($libtest);

$ffi->attach([get_string_from_array => 'a1'] => ['string_5_hey',  'int'] => 'string');
$ffi->attach([get_string_from_array => 'a2'] => ['string_5_undef', 'int'] => 'string');

my @list = ( 'foo', 'bar', 'baz', undef, 'five', 'six' );

subtest 'with default' => sub {
  is a1(\@list, 0), 'foo', 'a1(0) = foo';
  is a1(\@list, 1), 'bar', 'a1(0) = bar';
  is a1(\@list, 2), 'baz', 'a1(0) = baz';
  is a1(\@list, 3), 'hey', 'a1(0) = hey';
  is a1(\@list, 4), 'five', 'a1(0) = five';
  is a1(\@list, 5), undef, 'a1(0) = undef';
};

subtest 'with default' => sub {
  is a2(\@list, 0), 'foo', 'a2(0) = foo';
  is a2(\@list, 1), 'bar', 'a2(0) = bar';
  is a2(\@list, 2), 'baz', 'a2(0) = baz';
  is a2(\@list, 3), undef, 'a2(0) = undef';
  is a2(\@list, 4), 'five', 'a2(0) = five';
  is a2(\@list, 5), undef, 'a2(0) = undef';
};

done_testing;