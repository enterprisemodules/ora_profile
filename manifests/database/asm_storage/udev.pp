# ora_profile::database::asm_storage::udev
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::asm_storage::udev
class ora_profile::database::asm_storage::udev(
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Hash      $disk_devices,
) inherits ora_profile::database {
  file { '/etc/udev/rules.d/99-oracle-asmdevices.rules':
    ensure  => present,
    content => template("ora_profile/99-oracle-asmdevices-el${facts['os']['release']['major']}.rules.erb"),
    notify  => Exec['apply_udev_rules'],
  }
  exec { 'apply_udev_rules':
    command     => '/sbin/udevadm control --reload-rules && /sbin/udevadm trigger',
    refreshonly => true,
  }

}
