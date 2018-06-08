#++--++
#
# ora_profile::asm_software
#
# @summary This class contains the code to install Oracle Grid Infrastructure.
# Here you can customize some of the attributes of your database.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['12.2.0.1', '12.1.0.1', '12.1.0.2', '11.2.0.4']] version
#    The version of Oracle Grid Infrastructure you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::version`.
#
# @param [Array[Stdlib::Absolutepath]] dirs
#    The directories to create as part of the installation.
#    The default value is:
#    ```yaml
#    ora_profile::database::asm_software::dirs:
#    - /u01
#    - /u01/app/grid
#    - /u01/app/grid/admin
#    - /u01/app/grid/product
#    ```
#
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_group
#    The primary group of the owner(grid_user) of the installation.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_group`.
#
# @param [Stdlib::Absolutepath] grid_base
#    The ORACLE_BASE for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/admin`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_base`.
#
# @param [Stdlib::Absolutepath] grid_home
#    The ORACLE_HOME for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_home`.
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param [String[1]] file_name
#    The file name containing the Oracle Grid Infrastructure software kit.
#    The default is: `linuxx64_12201_grid_home`
#
# @param [String[1]] asm_sys_password
#    The `sys` password to use for ASM.
#    The default is: `Welcome01`
#
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
