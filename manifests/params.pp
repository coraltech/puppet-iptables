
class iptables::params {

  include iptables::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_exists {
    $allow_icmp = hiera('iptables_allow_icmp', $iptables::default::allow_icmp)
  }
  else {
    $allow_icmp = $iptables::default::allow_icmp
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_init_bin             = '/etc/network/if-pre-up.d/iptables'
      $os_init_bin_template    = 'iptables/iptables_init_script.erb'

      $os_save_bin             = '/sbin/iptables-save'
      $os_restore_bin          = '/sbin/iptables-restore'
      $os_rules_file           = '/etc/iptables.rules'
    }
    default: {
      fail("The iptables module is not currently supported on ${::operatingsystem}")
    }
  }
}
