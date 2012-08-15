
class iptables::exit (

  $init_bin             = $iptables::params::init_bin,
  $init_bin_template    = $iptables::params::init_bin_template,
  $save_bin             = $iptables::params::save_bin,
  $restore_bin          = $iptables::params::restore_bin,
  $rules_file           = $iptables::params::rules_file,

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
