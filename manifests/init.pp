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
#  $allow_icmp           = true,
#  $iptables_init_script = $iptables::params::iptables_init_script,
#  $iptables_save_bin    = $iptables::params::iptables_save_bin,
#  $iptables_restore_bin = $iptables::params::iptables_restore_bin,
#  $iptables_rules       = $iptables::params::iptables_rules
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
#   include iptables
#
# [Remember: No empty lines between comments and class definition]
class iptables (

  $allow_icmp           = $iptables::params::allow_icmp,
  $iptables_init_script = $iptables::params::iptables_init_script,
  $iptables_save_bin    = $iptables::params::iptables_save_bin,
  $iptables_restore_bin = $iptables::params::iptables_restore_bin,
  $iptables_rules       = $iptables::params::iptables_rules
)
inherits iptables::params {

  stage { ['iptables-init', 'iptables-exit']: }
  Stage['iptables-init'] -> Stage['main'] -> Stage['iptables-exit']

  #-----------------------------------------------------------------------------
  # Firewall rules

  class { 'iptables::pre_rules': stage => 'iptables-init' }

  if $allow_icmp {
    firewall { '101 INPUT allow ICMP':
      action => accept,
      icmp   => '8',
      proto  => 'icmp',
    }
  }

  class { 'iptables::post_rules':
    stage  => 'iptables-exit',
    notify => Class['iptables::exit'],
  }

  #-----------------------------------------------------------------------------
  # Finalization

  class { 'iptables::exit':
    stage                => 'iptables-exit',
    iptables_init_script => $iptables_init_script,
    iptables_save_bin    => $iptables_save_bin,
    iptables_restore_bin => $iptables_restore_bin,
    iptables_rules       => $iptables_rules,
  }

  resources { "firewall":
    purge => true
  }
}
