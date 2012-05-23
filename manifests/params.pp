
class iptables::params {

  #-----------------------------------------------------------------------------

  $iptables_save_bin    = '/sbin/iptables-save'
  $iptables_restore_bin = '/sbin/iptables-restore'
  $iptables_rules       = '/etc/iptables.rules'

  case $::operatingsystem {
    debian, ubuntu: {
      $iptables_init_script = '/etc/network/if-pre-up.d/iptables'
    }
    centos, redhat: {

    }
  }
}
