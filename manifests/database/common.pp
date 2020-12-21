#
# Common variables used my more then one class
#
class ora_profile::database::common(){
  $version              = lookup('ora_profile::database::version', Ora_Install::Version)
  $download_dir         = lookup('ora_profile::database::download_dir', String[1])
  $install_group        = lookup('ora_profile::database::install_group', String[1])
  $master_node          = lookup('ora_profile::database::master_node', Optional[String[1]], undef, $facts['hostname'])
  $ora_inventory_dir    = lookup('ora_profile::database::ora_inventory_dir', String[1])
  $grid_home            = lookup('ora_profile::database::grid_home', String[1])
  $grid_user            = lookup('ora_profile::database::grid_user', String[1])
  $temp_dir             = lookup('ora_profile::database::temp_dir', String[1])
  $cluster_nodes        = lookup('ora_profile::database::cluster_nodes', Optional[Array])
  $oracle_user_password = lookup('ora_profile::database::oracle_user_password', Optional[String[1]], undef, undef)
  $db_control_provider  = lookup('ora_profile::database::db_control_provider', Optional[String[1]])
  $is_rac               = !empty($cluster_nodes)
  $is_linux             = $::kernel == 'Linux'
  $is_windows           = $::kernel == 'Windows'
}

