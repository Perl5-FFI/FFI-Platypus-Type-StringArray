use strict;
use warnings;
use Test::More;
use FFI::CheckLib;
use FFI::Platypus;

my $libtest = find_lib lib => 'test', libpath => 'libtest';
plan skip_all => 'test requires a compiler'
  unless $libtest;

my $ffi = FFI::Platypus->new;
$ffi->lib($libtest);

subtest 'fixed length return' => sub {

  $ffi->load_custom_type('::StringArray' => 'sa3' =>  3);
  $ffi->load_custom_type('::StringArray' => 'sa3x' =>  3, 'x');

  is(
    $ffi->function(null => [] => 'sa3')->call,
    undef,
    'returns null',
  );

  is_deeply(
    $ffi->function(onetwothree3 => [] => 'sa3')->call,
    [ qw( one two three ) ],
    'returns with just strings',
  );

  is_deeply(
    $ffi->function(onenullthree3 => [] => 'sa3')->call,
    [ 'one', undef, 'three' ],
    'returns with NULL/undef in the middle',
  );

  is_deeply(
    $ffi->function(onenullthree3 => [] => 'sa3x')->call,
    [ 'one', 'x', 'three' ],
    'returns with NULL/undef in the middle',
  );

};

done_testing;
