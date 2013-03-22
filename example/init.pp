
node default {
  # This should be placed inside your top level node...
  #
  # See: site.pp  ( http://github.com/coraltech/puppet-lib )
  #
  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['iptables::post_rules'],
    require => Class['iptables::pre_rules'],
  }
  include iptables
}
