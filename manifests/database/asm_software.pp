#++--++

#--++--
class ora_profile::database::asm_software(
  Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.4']
            $version,
  Array[Stdlib::Absolutepath]
            $dirs,
  String[1] $grid_user,
  String[1] $grid_group,
  Stdlib::Absolutepath
            $grid_base,
  Stdlib::Absolutepath
            $grid_home,
  String[1] $source,
  String[1] $file_name,
  String[1] $asm_sys_password,
) inherits ora_profile::database {

  echo {"Ensure ASM software ${version} in ${grid_home}":
    withpath => false,
  }

  $configure_afd = false

  file{ $dirs:
    ensure => directory,
    owner  => $grid_user,
    group  => $grid_group,
    mode   => '0755',
  }

  file{ '/u01/app':
    ensure => directory,
    owner  => $grid_user,
    group  => $grid_group,
    mode   => '0775',
  }

  -> ora_install::installasm{ $file_name:
    version                   => $version,
    file                      => $file_name,
    grid_base                 => $grid_base,
    grid_home                 => $grid_home,
    puppet_download_mnt_point => $source,
    sys_asm_password          => $asm_sys_password,
    asm_monitor_password      => $asm_sys_password,
    asm_diskgroup             => 'DATA',
    disk_discovery_string     => case $configure_afd {
      true:  { '/dev/data*,/dev/reco*' }
      false: { '/nfs_client/asm*' }
      default: {}
    },
    disks                     => case $configure_afd {
      true:  { '/dev/data01' }
      false: { '/nfs_client/asm_sda_nfs_b1,/nfs_client/asm_sda_nfs_b2' }
      default: {}
    },
    disks_failgroup_names     => case $configure_afd {
      true:  { '/dev/data01,' }
      false: { '/nfs_client/asm_sda_nfs_b1,' }
      default: {}
    },
    disk_redundancy           => 'EXTERNAL',
    disk_au_size              => '4',
    configure_afd             => $configure_afd,
    user                      => $grid_user,
  }

  -> ora_setting{ '+ASM':
    default     => false,
    user        => 'sys',
    syspriv     => 'sysasm',
    oracle_home => $grid_home,
    os_user     => $grid_user,
  }

  -> file_line{ 'add_asm_to_oratab':
    path => '/etc/oratab',
    line => "+ASM:${grid_home}:N",
  }
}
