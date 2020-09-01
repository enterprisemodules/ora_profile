#++--++
#
# ora_profile::database::asm_storage::asmlib
#
# @summary This class configures ASMLib devices.
# Here is an example:
#
# ```puppet
#   include ora_profile::database::asm_storage::asmlib
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
# @param [Optional[String[1]]] scan_exclude
#    The devices that need to be excluded during scanning of the devices.
#
#--++--
class ora_profile::database::asm_storage::asmlib(
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Hash      $disk_devices,
  Optional[String[1]]
            $scan_exclude,
) inherits ora_profile::database {

  file{'/etc/sysconfig/oracleasm-_dev_oracleasm':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0775',
    content => epp('ora_profile/oracleasm-_dev_oracleasm.epp',{
      'grid_user'       => $grid_user,
      'grid_admingroup' => $grid_admingroup,
      'scan_exclude'    => $scan_exclude,
    }),
  }

  file{'/etc/sysconfig/oracleasm':
    ensure  => link,
    target  => '/etc/sysconfig/oracleasm-_dev_oracleasm',
    require => File['/etc/sysconfig/oracleasm-_dev_oracleasm'],
  }

  service{'oracleasm':
    ensure    => 'running',
    subscribe => File['/etc/sysconfig/oracleasm'],
    require   => Package['oracleasm-support'],
  }

  $disk_devices.each |$device, $values| {
    exec { "add asm label ${values['label']} to device /dev/${device}":
      command => "/usr/sbin/oracleasm createdisk ${values['label']} /dev/${device}_1",
      unless  => "/bin/bash -c \"while [ ! -e /dev/${device}_1 ]; do sleep 1 ;done\";/usr/sbin/oracleasm querydisk -v /dev/${device}_1",
      require => [
        Service['oracleasm'],
        Partition["/dev/${device}:1"],
      ]
    }
  }
}
