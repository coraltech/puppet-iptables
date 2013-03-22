
class iptables::post_rules {

  firewall { '950 INPUT log all rejected':
    chain      => 'INPUT',
    jump       => 'LOG',
    limit      => '5/min',
    before     => undef,
  }

  firewall { '999 Reject all':
    action  => reject,
    chain   => ['INPUT', 'FORWARD'],
    before  => undef,
  }
}
