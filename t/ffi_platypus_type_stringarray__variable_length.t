use strict;
use warnings;
use Test::More;
use FFI::CheckLib;
use FFI::Platypus;

my $ffi = FFI::Platypus->new;
$ffi->load_custom_type('::StringArray' => 'string_array');

my $libtest = find_lib lib => 'test', libpath => 'libtest';

plan skip_all => 'test requires a compiler'
  unless $libtest;

$ffi->lib($libtest);

$ffi->attach(get_string_from_array => ['string_array','int'] => 'string');

my @list = qw( foo bar baz );

for(0..2)
{
  is get_string_from_array(\@list, $_), $list[$_], "get_string_from_array(\@list, $_) = $list[$_]";
}

is get_string_from_array(\@list, 3), undef, "get_string_from_array(\@list, 3) = undef";

done_testing;
