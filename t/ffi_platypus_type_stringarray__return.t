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

$ffi->load_custom_type('::StringArray' => 'sa3' =>  3);

subtest 'fixed length' => sub {

  is(
    $ffi->function(null => [] => 'sa3')->call,
    undef,
    'returns null',
  );

  is_deeply(
    $ffi->function(onetwothree3 => [] => 'sa3')->call,
    [ qw( one two three ) ],
  );

};

done_testing;
