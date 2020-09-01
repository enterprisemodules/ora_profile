#++--++
#
# ora_profile::database::asm_storage::udev
#
# @summary This class will apply udev rules to specified disk devices.
# Here is an example:
#
# ```puppet
#   include ora_profile::database::asm_storage::udev
# ```
#
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_admingroup
#    The OS group to use for ASM admin.
#    The default value is: `asmadmin`
#
# @param [Hash] disk_devices
#    The disk devices that should be used.
#    Dependant on value specified for `ora_profile::database::asm_storage::storage_type`
#    Here is an example:
#    ```yaml
#    ora_profile::database::asm_storage::disk_devices:
#      asm_data01:
#        size: 8192
#        uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000'
#        label: 'DATA1'
#    ```
#
#--++--
class ora_profile::database::asm_storage::udev(
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Hash      $disk_devices,
) inherits ora_profile::database {
  file { '/etc/udev/rules.d/99-oracle-asmdevices.rules':
    ensure  => present,
    content => epp("ora_profile/99-oracle-asmdevices-el${facts['os']['release']['major']}.rules.epp",{
      'grid_user'       => $grid_user,
      'grid_admingroup' => $grid_admingroup,
      'disk_devices'    => $disk_devices,
    }),
    notify  => Exec['apply_udev_rules'],
  }
  exec { 'apply_udev_rules':
    command     => '/sbin/udevadm control --reload-rules && /sbin/udevadm trigger',
    refreshonly => true,
  }

}
