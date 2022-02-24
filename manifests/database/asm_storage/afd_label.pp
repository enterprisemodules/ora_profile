# ora_profile::database::asm_storage::afd_label
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::asm_storage::afd_label
class ora_profile::database::asm_storage::afd_label () {
  $grid_home = lookup('ora_profile::database::grid_home')
  $grid_user = lookup('ora_profile::database::grid_user')
  $grid_base = lookup('ora_profile::database::grid_base')

  easy_type::debug_evaluation() # Show local variable on extended debug

  $ora_profile::database::asm_storage::disk_devices.each |$device, $values| {
    exec { "add afd label ${values['label']} to device /dev/${device}":
      command     => "${grid_home}/bin/asmcmd afd_label ${values['label']} /dev/${device}",
      environment => ["ORACLE_HOME=${grid_home}","ORACLE_BASE=${grid_base}"],
      user        => $grid_user,
      path        => "/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:${grid_home}/bin",
      unless      => "${grid_home}/bin/asmcmd afd_lslbl /dev/${device} | grep '^${values['label']} .* /dev/${device}$'",
    }
  }
}
