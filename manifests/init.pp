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

  $allow_icmp = $iptables::params::allow_icmp

) inherits iptables::params {

  #-----------------------------------------------------------------------------
  # Basic firewall rules

  include firewall

  # These are added to the Firewall execution flow in site.pp
  include iptables::pre_rules
  include iptables::post_rules

  if $allow_icmp {
    firewall { '101 INPUT allow ICMP':
      action => accept,
      icmp   => '8',
      proto  => 'icmp',
    }
  }
}
