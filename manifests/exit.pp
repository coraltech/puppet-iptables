
class iptables::exit (

  $init_bin             = $iptables::params::os_init_bin,
  $save_bin             = $iptables::params::os_save_bin,
  $restore_bin          = $iptables::params::os_restore_bin,
  $rules_file           = $iptables::params::os_rules_file,
  $init_bin_template    = $iptables::params::os_init_bin_template,

) inherits iptables::params {

  #-----------------------------------------------------------------------------
  # Persistence

  exec { 'persist-firewall':
    command => "${save_bin} > ${rules_file}",
  }

  #-----------------------------------------------------------------------------
  # Restoration

  if $init_bin {
    file { 'iptables-init-bin':
      path      => $init_bin,
      owner     => "root",
      group     => "root",
      mode      => 755,
      content   => template($init_bin_template),
      subscribe => Exec['persist-firewall'],
    }
  }
}
