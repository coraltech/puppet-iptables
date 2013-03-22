
class iptables::params inherits iptables::default {

  $allow_icmp = module_param('allow_icmp')
}
