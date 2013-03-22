
class iptables::default {

  $allow_icmp = true

  #---

  $ensure      = 'present'
  $action      = undef
  $source      = undef
  $destination = undef
  $sport       = undef
  $dport       = undef
  $port        = undef
  $proto       = 'tcp'
  $tcp_flags   = undef
  $chain       = 'INPUT'
  $table       = 'filter'
  $jump        = undef
  $iniface     = undef
  $outiface    = undef
  $tosource    = undef
  $todest      = undef
  $toports     = undef
  $reject      = undef
  $log_level   = undef
  $log_prefix  = undef
  $icmp        = undef
  $state       = undef
  $limit       = undef
  $burst       = undef
  $uid         = undef
  $gid         = undef
  $set_mark    = undef
  $pkttype     = 'unicast'
  $socket      = undef

  #---

  case $::operatingsystem {
    debian, ubuntu: {

    }
    default: {
      fail("The iptables module is not currently supported on ${::operatingsystem}")
    }
  }
}
