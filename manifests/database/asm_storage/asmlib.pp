# ora_profile::database::asm_storage::asmlib
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::asm_storage::asmlib
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
    content => template('ora_profile/oracleasm-_dev_oracleasm.erb'),
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
