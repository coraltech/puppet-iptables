# Class: iptables
#
#   This module creates an extensible firewall rule system and a locked down
#   default.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
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

  $allow_icmp        = $iptables::params::allow_icmp,
  $init_bin          = $iptables::params::init_bin,
  $init_bin_template = $iptables::params::init_bin_template,
  $save_bin          = $iptables::params::save_bin,
  $restore_bin       = $iptables::params::restore_bin,
  $rules_file        = $iptables::params::rules_file,

) inherits iptables::params {

  stage { ['iptables-init', 'iptables-exit']: }
  Stage['iptables-init'] -> Stage['main'] -> Stage['iptables-exit']

  #-----------------------------------------------------------------------------
  # Basic firewall rules

  class { 'iptables::pre_rules': stage => 'iptables-init' }

  if $allow_icmp == 'true' {
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
    stage             => 'iptables-exit',
    init_bin          => $init_bin,
    init_bin_template => $init_bin_template,
    save_bin          => $save_bin,
    restore_bin       => $restore_bin,
    rules_file        => $rules_file,
  }

  resources { "firewall":
    purge => true
  }
}
