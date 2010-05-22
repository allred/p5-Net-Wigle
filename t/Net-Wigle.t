# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-Wigle.t'

use Test::More qw(no_plan);
BEGIN { use_ok('Net::Wigle') };
ok(my $nw = Net::Wigle->new, "new") or diag 'instantiation failed';
ok($nw->clone, 'isa LWP::UserAgent') or diag "subclassing problem";
isa_ok(
  $nw->query_raw(
    ssid => 'lauchita',
  ), 
  'HTTP::Response',
) or diag "query failed";
