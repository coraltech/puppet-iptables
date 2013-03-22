
class iptables::params inherits iptables::default {

  $allow_icmp = module_param('allow_icmp')

  #---

  $ensure      = module_param('ensure')
  $action      = module_param('action')
  $source      = module_param('source')
  $destination = module_param('destination')
  $sport       = module_param('sport')
  $dport       = module_param('dport')
  $port        = module_param('port')
  $proto       = module_param('proto')
  $tcp_flags   = module_param('tcp_flags')
  $chain       = module_param('chain')
  $table       = module_param('table')
  $jump        = module_param('jump')
  $iniface     = module_param('iniface')
  $outiface    = module_param('outiface')
  $tosource    = module_param('tosource')
  $todest      = module_param('todest')
  $toports     = module_param('toports')
  $reject      = module_param('reject')
  $log_level   = module_param('log_level')
  $log_prefix  = module_param('log_prefix')
  $icmp        = module_param('icmp')
  $state       = module_param('state')
  $limit       = module_param('limit')
  $burst       = module_param('burst')
  $uid         = module_param('uid')
  $gid         = module_param('gid')
  $set_mark    = module_param('set_mark')
  $pkttype     = module_param('pkttype')
  $socket      = module_param('socket')
}
