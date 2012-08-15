
class iptables::default {

  $allow_icmp = 'true'

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $init_bin          = '/etc/network/if-pre-up.d/iptables'
      $init_bin_template = 'iptables/iptables_init_script.erb'

      $save_bin          = '/sbin/iptables-save'
      $restore_bin       = '/sbin/iptables-restore'
      $rules_file        = '/etc/iptables.rules'
    }
    default: {
      fail("The iptables module is not currently supported on ${::operatingsystem}")
    }
  }
}
