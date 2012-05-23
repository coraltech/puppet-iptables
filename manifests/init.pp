# Class: iptables
#
#   This module creates an extensible firewall rule system and a locked down
#   default.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#   $allow_icmp = true
#
# Actions:
#
#   Configures iptables with basic rules and allows for other modules to
#   plugin new rules
#
# Requires:
#
#   Firewall module
#
# Sample Usage:
#
#   class { 'iptables':
#     allow_icmp => false
#   }
#
# [Remember: No empty lines between comments and class definition]
class iptables ( $allow_icmp = true ) {

  include iptables::params

  #-----------------------------------------------------------------------------

  if $iptables::params::iptables_init_script {
    file { $iptables::params::iptables_init_script:
      owner    => "root",
      group    => "root",
      mode     => 755,
      content  => template("iptables/iptables_init_script.erb"),
    }
  }

  #-----------------------------------------------------------------------------

  exec { "persist-firewall":
    command     => "${iptables::params::iptables_save_bin} > ${iptables::params::iptables_rules}",
    refreshonly => true,
  }

  ::Firewall {
    notify => Exec["persist-firewall"]
  }

  #-----------------------------------------------------------------------------

  class { 'iptables::firewall': allow_icmp => $allow_icmp }
}
