#++--++
#
# ora_profile::db_software
#
# @summary This class contains the definition of the Oracle software you want to use on this system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['11.2.0.1',
#     '11.2.0.3',
#     '11.2.0.4',
#     '12.1.0.1',
#     '12.1.0.2',
#     '12.2.0.1',
#     '18.0.0.0']] version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
# @param [Enum['SE2', 'SE', 'EE', 'SEONE']] database_type
#    The type of database to define.
#    The default value is: `SE2`.
#
# @param [Array[Stdlib::Absolutepath]] dirs
#    The directories to create as part of the installation.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_software::dirs:
#      - /u02
#      - /u03
#      - /u02/oradata
#      - /u03/fast_recovery_area
#    ```
#
# @param [String[1]] dba_group
#    The group to use for Oracle DBA users.
#    The default is : `dba`
#    To customize this consistently use the hiera key `ora_profile::database::dba_group`.
#
# @param [String[1]] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param [String[1]] file_name
#    The file name containing the Oracle database software kit.
#    The default is: `linuxx64_12201_database`
#
#--++--
# lint:ignore:variable_scope
class ora_profile::database::db_software(
  Ora_Install::Version
            $version,
  Enum['SE2', 'SE', 'EE', 'SEONE']
            $database_type,
  Array[Stdlib::Absolutepath]
            $dirs,
  String[1] $dba_group,
  String[1] $oper_group,
  String[1] $os_user,
  Boolean   $bash_profile,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $source,
  String[1] $file_name,
) inherits ora_profile::database {

  echo {"Ensure DB software ${version} ${database_type} in ${oracle_home}":
    withpath => false,
  }

  unless defined(Package['unzip']) {
    package { 'unzip':
      ensure => 'present',
    }
  }

  unless defined(File[$download_dir]) {
    file { $download_dir:
      ensure => 'directory',
    }
  }

  $dirs.each |$dir| {
    unless defined(File[$dir]) {
      file{$dir:
        ensure  => directory,
        owner   => $os_user,
        group   => $install_group,
        seltype => 'default_t',
        mode    => '0770',
      }
    }
  }

  if ( $master_node == $facts['hostname'] ) {
    if ( $is_rac ) {
      $installdb_cluster_nodes = $master_node
    } else {
      $installdb_cluster_nodes = undef
    }
    ora_install::installdb{$file_name:
      version                   => $version,
      file                      => $file_name,
      database_type             => $database_type,
      oracle_base               => $oracle_base,
      oracle_home               => $oracle_home,
      puppet_download_mnt_point => $source,
      bash_profile              => $bash_profile,
      group                     => $dba_group,
      group_install             => $install_group,
      group_oper                => $oper_group,
      user                      => $os_user,
      cluster_nodes             => $installdb_cluster_nodes,
      ora_inventory_dir         => $ora_inventory_dir,
      require                   => [
        File[$dirs],
        Package['unzip'],
        File[$download_dir],
      ],
    }
  } else {
    echo {"This is not the master node. Clone ORACLE_HOME from ${master_node}":
      withpath => false,
    }

    case $version {
      '12.2.0.1': {
        $add_node_command = "${oracle_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['hostname']}-vip}\" \"CLUSTER_NEW_NODE_ROLES={HUB}\""
      }
      '12.1.0.2': {
        $add_node_command = "${oracle_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['hostname']}-vip}\""
      }
      '11.2.0.4': {
        $add_node_command = "IGNORE_PREADDNODE_CHECKS=Y ${oracle_home}/oui/bin/addNode.sh -ignorePrereq \"CLUSTER_NEW_NODES={${::hostname}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${::hostname}-vip}\""
      }
      default: {
        notice('Version not supported yet')
      }
    }

    exec{'add_oracle_node':
      timeout   => 0,
      user      => $os_user,
      command   => "/usr/bin/ssh ${os_user}@${master_node} \"${add_node_command}\"",
      logoutput => on_failure,
      creates   => "${oracle_home}/root.sh",
    }

    ~> exec{'register_oracle_node':
      refreshonly => true,
      timeout     => 0,
      user        => 'root',
      command     => "/bin/sh ${$ora_inventory_dir}/oraInventory/orainstRoot.sh;/bin/sh ${oracle_home}/root.sh",
      logoutput   => on_failure,
    }
  }

  file {"${oracle_base}/admin":
    ensure => 'directory',
    owner  => $os_user,
    group  => $install_group,
    mode   => '0775',
  }

}
# lint:endignore
