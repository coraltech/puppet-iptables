
class iptables::post_rules {

  firewall { '950 INPUT log all rejected':
    chain      => 'INPUT',
    jump       => LOG,
    limit      => '5/min',
    log_level  => 7,
    log_prefix => "iptables denied: ",
  }

  firewall { '999 Reject all':
    action  => reject,
    chain   => ['INPUT', 'FORWARD'],
  }
}
