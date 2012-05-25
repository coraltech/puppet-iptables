
class iptables::exit (

  $iptables_init_script = $iptables::params::iptables_init_script,
  $iptables_save_bin    = $iptables::params::iptables_save_bin,
  $iptables_restore_bin = $iptables::params::iptables_restore_bin,
  $iptables_rules       = $iptables::params::iptables_rules
)
inherits iptables::params {

  #-----------------------------------------------------------------------------
  # Last remaining system rules.

  class { 'iptables::post_rules':
    notify => Exec['persist-firewall']
  }

  #-----------------------------------------------------------------------------
  # Save rules.

  exec { 'persist-firewall':
    command => "${iptables_save_bin} > ${iptables_rules}",
  }

  #-----------------------------------------------------------------------------
  # Restore rules at boot.

  if $iptables_init_script {
    file { $iptables_init_script:
      owner     => "root",
      group     => "root",
      mode      => 755,
      content   => template("iptables/iptables_init_script.erb"),
      subscribe => Exec['persist-firewall'],
    }
  }
}
