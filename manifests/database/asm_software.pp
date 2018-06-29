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
  String[1] $source,
  String[1] $file_name,
  String[1] $asm_sys_password,
  String[1] $disk_discovery_string,
  String[1] $asm_diskgroup,
  String[1] $asm_disks,
  Boolean   $configure_afd,
  Enum['CRS_CONFIG','HA_CONFIG','UPGRADE','CRS_SWONLY','HA_SWONLY']
            $grid_type,
  Optional[String[1]]
            $disks_failgroup_names,
  Optional[String[1]]
            $cluster_name,
  Optional[String[1]]
            $scan_name,
  Optional[Integer]
            $scan_port,
  Optional[String[1]]
            $cluster_node_types,
  Optional[String[1]]
            $network_interface_list,
  Optional[Enum['FLEX_ASM_STORAGE','CLIENT_ASM_STORAGE','LOCAL_ASM_STORAGE','FILE_SYSTEM_STORAGE','ASM_STORAGE']]
            $storage_option,
) inherits ora_profile::database {

  echo {"Ensure ASM software ${version} in ${grid_home}":
    withpath => false,
  }

  file{ $dirs:
    ensure => directory,
    owner  => $grid_user,
    group  => $install_group,
    mode   => '0755',
  }

  file{ '/u01/app':
    ensure => directory,
    owner  => $grid_user,
    group  => $install_group,
    mode   => '0775',
  }

  -> file {$download_dir:
    ensure  => directory,
    owner   => $os_user,
    group   => $install_group,
    seltype => 'default_t',
    mode    => '0775',
  }

  if ( $master_node == $facts['hostname'] ) {
    # Ora_install::installasm[$file_name] -> Ora_setting[$asm_instance_name]

    ora_install::installasm{ $file_name:
      version                   => $version,
      file                      => $file_name,
      grid_base                 => $grid_base,
      grid_home                 => $grid_home,
      puppet_download_mnt_point => $source,
      sys_asm_password          => $asm_sys_password,
      asm_monitor_password      => $asm_sys_password,
      asm_diskgroup             => $asm_diskgroup,
      disk_discovery_string     => $disk_discovery_string,
      disks                     => $asm_disks,
      disks_failgroup_names     => $disks_failgroup_names,
      disk_redundancy           => 'EXTERNAL',
      disk_au_size              => '4',
      configure_afd             => $configure_afd,
      grid_type                 => $grid_type,
      user                      => $grid_user,
      cluster_nodes             => $cluster_node_types,
      cluster_name              => $cluster_name,
      scan_name                 => $scan_name,
      scan_port                 => $scan_port,
      network_interface_list    => $network_interface_list,
      storage_option            => $storage_option,
      before                    => Ora_setting[$asm_instance_name],
    }
  } else {
    echo {"This is not the master node. Clone GRID_HOME from ${master_node}":
      withpath => false,
    }

    Exec['register_grid_node'] -> Ora_setting[$asm_instance_name]

    case $version {
      '12.2.0.1': {
        $add_node_command = "${grid_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['hostname']}-vip}\" \"CLUSTER_NEW_NODE_ROLES={HUB}\""
      }
      default: {
        notice('Version not supported yet')
      }
    }
    exec{'add_grid_node':
      timeout => 0,
      user    => $grid_user,
      command => "/usr/bin/ssh ${grid_user}@${master_node} \"${add_node_command}\"",
      creates => "${grid_home}/root.sh",
    }

    -> exec{'register_grid_node':
      timeout => 0,
      user    => 'root',
      creates => "${grid_base}/${facts['hostname']}",
      returns => [0,25],
      command => "/bin/sh ${ora_inventory_dir}/oraInventory/orainstRoot.sh;/bin/sh ${grid_home}/root.sh",
      before  => Ora_setting[$asm_instance_name],
    }
  }

  ora_setting{ $asm_instance_name:
    default     => false,
    user        => 'sys',
    syspriv     => 'sysasm',
    oracle_home => $grid_home,
    os_user     => $grid_user,
  }

  -> file_line{ 'add_asm_to_oratab':
    path  => '/etc/oratab',
    line  => "${asm_instance_name}:${grid_home}:N",
    match => "^${asm_instance_name}:${grid_home}:N.*",
  }
}
