
class iptables::pre_rules {

  Firewall {
    require => undef,
  }

  #---

  firewall { '001 INPUT allow loopbacks':
    action  => accept,
    chain   => 'INPUT',
    iniface => 'lo',
  }

  firewall { '002 OUTPUT allow loopback':
    action   => accept,
    chain    => 'OUTPUT',
    outiface => 'lo',
  }

  firewall { '050 Allow related and established':
    action => accept,
    state  => ['RELATED', 'ESTABLISHED'],
  }

  firewall { '090 OUTPUT allow all outbound':
    action => accept,
    chain  => 'OUTPUT',
  }
}
