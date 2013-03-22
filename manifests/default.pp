
class iptables::default {

  $allow_icmp = true

  #---

  case $::operatingsystem {
    debian, ubuntu: {

    }
    default: {
      fail("The iptables module is not currently supported on ${::operatingsystem}")
    }
  }
}
