
class iptables::firewall ( $allow_icmp = true ) {

  #-----------------------------------------------------------------------------

  stage { pre: before => Stage[main] }
  stage { post: require => Stage[main] }

  #-----------------------------------------------------------------------------
  # Initialize firewall rules

  class iptables::pre_rules {

    firewall { '001 INPUT allow loopback':
      action => accept,
      chain => 'INPUT',
      outiface => 'lo',
    }
    firewall { '002 OUTPUT allow loopback':
      action => accept,
      chain => 'OUTPUT',
      iniface => 'lo',
    }
    firewall { '050 allow related and established':
      action => accept,
      state => ['RELATED', 'ESTABLISHED'],
    }
    firewall { '099 OUTPUT allow all outbound':
      action => accept,
      chain => 'OUTPUT',
    }
  }

  class { 'iptables::pre_rules': stage => 'pre' }

  #-----------------------------------------------------------------------------
  # Add core rules

  if $allow_icmp == true {
    firewall { '150 INPUT allow ICMP':
      action => accept,
      icmp => '8',
      proto => 'icmp',
    }
  }

  #-----------------------------------------------------------------------------
  # Add final firewall rules after all other rules have been registered

  class iptables::post_rules {

    firewall { "980 INPUT log all rejected":
      chain => 'INPUT',
      limit => '5/min',
      log_level => 7,
      log_prefix => "iptables denied: ",
    }
    firewall { "999 reject all":
      action => reject,
      chain => ['INPUT', 'FORWARD'],
    }

    resources { 'firewall':
      purge => true,
    }
  }

  class { 'iptables::post_rules': stage => 'post' }
}
