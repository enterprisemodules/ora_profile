#
# ora_profile::database::asm_software
#
# @summary This class contains the code to install Oracle Grid Infrastructure.
# Here you can customize some of the attributes of your database.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Ora_Install::Version] version
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
# @param [String[1]] file_name
#    The file name containing the Oracle Grid Infrastructure software kit.
#    The default is: `linuxx64_12201_grid_home`
#
# @param [Easy_type::Password] asm_sys_password
#    The `sys` password to use for ASM.
#    The default is: `Welcome01`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_sys_password`.
#
# @param [String[1]] disk_discovery_string
#    The disk discovery string for ASM.
#    The default value is: `/nfs_client/asm*`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::disk_discovery_string`.
#
# @param [String[1]] asm_diskgroup
#    The name of the ASM diskgroup to use.
#    The default value is: `DATA`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_diskgroup`.
#
# @param [String[1]] asm_disks
#    List of disks to create a ASM DiskGroup.
#    The default value is: `/nfs_client/asm_sda_nfs_b1,/nfs_client/asm_sda_nfs_b2`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_disks`.
#
# @param [String[1]] group
#    The dba group for ASM.
#    The default is : `asmdba`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::group`.
#
# @param [String[1]] oper_group
#    The oper group for ASM.
#    The default is : `asmoper`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::oper_group`.
#
# @param [String[1]] asm_group
#    The admin group for ASM.
#    The default is : `asmadmin`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_group`.
#
# @param [Boolean] configure_afd
#    Specify whether or not to configure ASM Filter Driver instead of ASMLib.
#    The default value is: `false`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::configure_afd`.
#
# @param [Enum['CRS_CONFIG', 'HA_CONFIG', 'UPGRADE', 'CRS_SWONLY', 'HA_SWONLY']] grid_type
#    The type of grid.
#    Valid values are:
#    - `HA_CONFIG`
#    - `CRS_CONFIG`
#    - `HA_SWONLY`   (versions > 11)
#    - `UPGRADE`
#    - `CRS_SWONLY`
#    The default value is: `HA_CONFIG`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_type`.
#
# @param [Enum['EXTENDED', 'EXTERNAL', 'FLEX', 'HIGH', 'NORMAL']] disk_redundancy
#    The disk redundancy for the initial diskgroup to setup ASM.
#    Valid values are:
#    - `EXTENDED`
#    - `EXTERNAL`
#    - `FLEX`
#    - `HIGH`
#    - `NORMAL`
#    The default value is: `EXTERNAL`
#
# @param [Enum['ALL', 'EXTRACT']] install_task
#    The installation task that should be executed.
#
# @param [Boolean] bash_profile
#    Whether or not to deploy bash_profile for $os_user or $grid_user
#    The default is : `true`
#
# @param [String] bash_additions
#    The text to add at the end of the bash_profile.
#    This parameter will only be used when you have specified `true` for the parameter `bash_profile`
#    The default value is an empty string.
#
# @param [Optional[String[1]]] disks_failgroup_names
#    A comma seperated list of device and failure group name.
#    Valid values are:
#    - `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3`                                 (NORMAL redundancy)
#    - `/dev/sdb,,/dev/sdc,,/dev/sdd,,/dev/sde,`                                         (EXTERNAL redundancy)
#    - `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3,/dev/sde,CRSFG4,/dev/sdf,CRSFG5` (HIGH redundancy)
#    The default value is: `/nfs_client/asm_sda_nfs_b1,`
#
# @param [Optional[String[1]]] cluster_name
#    The name of the cluster.
#    The default value is: `undef`
#
# @param [Optional[String[1]]] scan_name
#    The hostname to use for the SCAN service.
#    The default value is: `undef`
#
# @param [Optional[Integer]] scan_port
#    The IP portnumber to use for the SCAN service.
#    The default value is: `undef`
#
# @param [Optional[String[1]]] cluster_node_types
#    The names of the nodes in the RAC cluster.
#    Valid values are:
#    - `node1:node1-vip,node2:node2-vip`                     (version >= 11 <= 12.1)
#    - `node1:node1-vip:HUB,node2:node2-vip:LEAF`            (version >= 12.1 Flex Cluster)
#    - `node1,node2`                                         (version = 12.2 Application Cluster)
#    - `node1:node1-vip:HUB:site1,node2:node2-vip:HUB:site2` (version = 12.2 Extended Cluster)
#    The default value is: `undef`
#
# @param [Optional[String[1]]] network_interface_list
#    
#    The list of interfaces to use for RAC.The value should be a comma separated strings where each string is as shown below```InterfaceName:SubnetAddress:InterfaceType```where InterfaceType can be either "1", "2", "3", "4" or "5" (1 indicates public, 2 indicates private, 3 indicates the interface is not used, 4 indicates ASM and 5 indicates ASM & Private)The default value is: `undef`
#
# @param [Optional[Enum['FLEX_ASM_STORAGE', 'CLIENT_ASM_STORAGE', 'LOCAL_ASM_STORAGE', 'FILE_SYSTEM_STORAGE', 'ASM_STORAGE']]] storage_option
#    The type of storage to use.
#    Valid values are:
#    - `ASM_STORAGE`          (versions = 11)
#    - `FILE_SYSTEM_STORAGE`  (versions <= 12.1)
#    - `LOCAL_ASM_STORAGE`    (versions >= 12.1)
#    - `CLIENT_ASM_STORAGE`   (versions >= 12.2)
#    - `FLEX_ASM_STORAGE`     (versions >= 12.1)
#    The default value is: `undef`
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::asm_software (
# lint:ignore:strict_indent
  String[1] $asm_diskgroup,
  String[1] $asm_disks,
  String[1] $asm_group,
  Easy_type::Password
            $asm_sys_password,
  String    $bash_additions,
  Boolean   $bash_profile,
  Optional[String[1]]
            $cluster_name,
  Optional[String[1]]
            $cluster_node_types,
  Boolean   $configure_afd,
  Array[Stdlib::Absolutepath]
            $dirs,
  String[1] $disk_discovery_string,
  Enum['EXTENDED','EXTERNAL','FLEX','HIGH','NORMAL']
            $disk_redundancy,
  Optional[String[1]]
            $disks_failgroup_names,
  String[1] $file_name,
  Enum['CRS_CONFIG','HA_CONFIG','UPGRADE','CRS_SWONLY','HA_SWONLY']
            $grid_type,
  String[1] $group,
  Enum['ALL','EXTRACT']
            $install_task,
  Optional[String[1]]
            $network_interface_list,
  String[1] $oper_group,
  Optional[String[1]]
            $scan_name,
  Optional[Integer]
            $scan_port,
  Optional[Enum['FLEX_ASM_STORAGE','CLIENT_ASM_STORAGE','LOCAL_ASM_STORAGE','FILE_SYSTEM_STORAGE','ASM_STORAGE']]
            $storage_option,
  Ora_Install::Version
            $version
) inherits ora_profile::database {
# lint:endignore:strict_indent
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { "Ensure ASM Software ${version} in ${grid_home}":
    withpath => false,
  }

  $dirs.each |$dir| {
    unless defined(File[$dir]) {
      file { $dir:
        ensure  => directory,
        owner   => $grid_user,
        group   => $install_group,
        seltype => 'default_t',
        mode    => '0770',
      }
    }
  }

  file { '/u01/app':
    ensure => directory,
    owner  => $grid_user,
    group  => $install_group,
    mode   => '0775',
  }

  -> file { $download_dir:
    ensure  => directory,
    owner   => $os_user,
    group   => $install_group,
    seltype => 'default_t',
    mode    => '0775',
  }

  if ( $master_node == $facts['networking']['hostname'] ) {
    ora_install::installasm { "Install GRID version ${version} in ${grid_home}":
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
      disk_redundancy           => $disk_redundancy,
      disk_au_size              => '4',
      configure_afd             => $configure_afd,
      grid_type                 => $grid_type,
      group                     => $group,
      group_install             => $install_group,
      group_oper                => $oper_group,
      group_asm                 => $asm_group,
      user                      => $grid_user,
      cluster_nodes             => $cluster_node_types,
      cluster_name              => $cluster_name,
      scan_name                 => $scan_name,
      scan_port                 => $scan_port,
      network_interface_list    => $network_interface_list,
      storage_option            => $storage_option,
      ora_inventory_dir         => $ora_inventory_dir,
      download_dir              => $download_dir,
      temp_dir                  => $temp_dir,
      bash_profile              => $bash_profile,
      bash_additions            => $bash_additions,
      install_task              => $install_task,
    }
    $require_install = Ora_install::Installasm["Install GRID version ${version} in ${grid_home}"]
  } else {
    unless ( $grid_home in $facts['ora_install_homes']['product_version'].keys ) {
      echo { "This is not the master node. Clone GRID_HOME from ${master_node}":
        withpath => false,
      }
      case $version {
        '18.0.0.0', '19.0.0.0', '21.0.0.0': {
          $add_node_rsp = "${download_dir}/add_node_${facts['networking']['hostname']}.rsp"
          $add_node_command = "${grid_home}/gridSetup.sh -silent -waitForCompletion -skipPrereqs -responseFile ${add_node_rsp}"
          $ora_inventory = "${ora_inventory_dir}/oraInventory"
          file { $add_node_rsp:
            ensure  => file,
            content => epp("ora_profile/grid_addnode_${version}.rsp.epp", {
                'ora_inventory'          => $ora_inventory,
                'grid_base'              => $grid_base,
                'cluster_name'           => $cluster_name,
                'hostname'               => $facts['networking']['hostname'],
                'network_interface_list' => $network_interface_list,
            }),
            mode    => '0770',
            owner   => $grid_user,
            group   => $group,
          }

          exec { "${add_node_rsp}@${master_node}":
            timeout => 0,
            user    => $grid_user,
            command => "/usr/bin/scp ${add_node_rsp} ${grid_user}@${master_node}:${add_node_rsp}",
            require => File[$add_node_rsp],
            before  => Exec['add_grid_node'],
          }
        }
        '12.2.0.1': {
          $add_node_command = "${grid_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['networking']['hostname']}-vip}\" \"CLUSTER_NEW_NODE_ROLES={HUB}\""
        }
        '12.1.0.2': {
          $add_node_command = "${grid_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['networking']['hostname']}-vip}\""
        }
        '11.2.0.4': {
          $add_node_command = "IGNORE_PREADDNODE_CHECKS=Y ${grid_home}/oui/bin/addNode.sh -silent -ignorePrereq -ignoreSysPrereqs \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['networking']['hostname']}-vip}\""
        }
        default: {
          notice('Version not supported yet')
        }
      }
      exec { 'add_grid_node':
        timeout => 0,
        user    => $grid_user,
        umask   => '0022',
        command => "/usr/bin/ssh ${grid_user}@${master_node} \"${add_node_command}\"",
        creates => "${grid_home}/root.sh",
      }

      ~> exec { 'register_grid_node':
        refreshonly => true,
        timeout     => 0,
        user        => 'root',
        returns     => [0,25],
        command     => "/bin/sh ${ora_inventory_dir}/oraInventory/orainstRoot.sh;/bin/sh ${grid_home}/root.sh",
      }
      $require_install = Exec['register_grid_node']
    }
  }

  if ( $install_task == 'ALL' ) {
    ora_setting { $asm_instance_name:
      default     => false,
      user        => 'sys',
      syspriv     => 'sysasm',
      oracle_home => $grid_home,
      os_user     => $grid_user,
      require     => $require_install,
      daemonized  => false,
    }

    -> ora_tab_entry { $asm_instance_name:
      ensure      => 'present',
      oracle_home => $grid_home,
      startup     => 'N',
      comment     => 'Grid instance added by Puppet',
    }
  }
}
# lint:endignore
