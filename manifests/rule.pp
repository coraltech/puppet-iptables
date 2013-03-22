
define iptables::rule (

  $rule        = $name,
  $ensure      = $iptables::params::ensure,
  $action      = $iptables::params::action,
  $source      = $iptables::params::source,
  $destination = $iptables::params::destination,
  $sport       = $iptables::params::sport,
  $dport       = $iptables::params::dport,
  $port        = $iptables::params::port,
  $proto       = $iptables::params::proto,
  $tcp_flags   = $iptables::params::tcp_flags,
  $chain       = $iptables::params::chain,
  $table       = $iptables::params::table,
  $jump        = $iptables::params::jump,
  $iniface     = $iptables::params::iniface,
  $outiface    = $iptables::params::outiface,
  $tosource    = $iptables::params::tosource,
  $todest      = $iptables::params::todest,
  $toports     = $iptables::params::toports,
  $reject      = $iptables::params::reject,
  $log_level   = $iptables::params::log_level,
  $log_prefix  = $iptables::params::log_prefix,
  $icmp        = $iptables::params::icmp,
  $state       = $iptables::params::state,
  $limit       = $iptables::params::limit,
  $burst       = $iptables::params::burst,
  $uid         = $iptables::params::uid,
  $gid         = $iptables::params::gid,
  $set_mark    = $iptables::params::set_mark,
  $pkttype     = $iptables::params::pkttype,
  $socket      = $iptables::params::socket

) {

  #-----------------------------------------------------------------------------
  # Configuration

  firewall { $rule:
    ensure      => $ensure,
    action      => $action,
    source      => $source,
    destination => $destination,
    sport       => $sport,
    dport       => $dport,
    port        => $port,
    proto       => $proto,
    tcp_flags   => $tcp_flags,
    chain       => $chain,
    table       => $table,
    jump        => $jump,
    iniface     => $iniface,
    outiface    => $outiface,
    tosource    => $tosource,
    todest      => $todest,
    toports     => $toports,
    reject      => $reject,
    log_level   => $log_level,
    log_prefix  => $log_prefix,
    icmp        => $icmp,
    state       => $state,
    limit       => $limit,
    burst       => $burst,
    uid         => $uid,
    gid         => $gid,
    set_mark    => $set_mark,
    pkttype     => $pkttype,
    socket      => $socket
  }
}
