
class iptables::params inherits iptables::default {

  $init_bin          = module_param('init_bin')
  $init_bin_template = module_param('init_bin_template')

  $save_bin          = module_param('save_bin')
  $restore_bin       = module_param('restore_bin')
  $rules_file        = module_param('rules_file')

  #---

  $allow_icmp        = module_param('allow_icmp')
}
