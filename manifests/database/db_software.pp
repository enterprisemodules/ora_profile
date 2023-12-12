#
# ora_profile::database::db_software
#
# @summary This class contains the definition of the Oracle software you want to use on this system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Ora_Install::Version] version
#    The version of Oracle you want to install.
#    The default is : `19.0.0.0`
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
# @param [String[1]] oper_group
#    The oper group for the database.
#    The default is : `oper`
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Variant[Stdlib::Absolutepath, Hash]] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home` for a single ORACLE_HOME.
#    This parameter can also be specified as Hash if you need to install multiple ORACLE_HOME's.
#    The keys of the hash are just a name.
#    For every key all parameters that are valid for ora_install::installdb can be specified.
#    For example:
#    ```yaml
#    ora_profile::database::db_software::oracle_home:
#      18cORACLE_HOME1:
#        version:     "%{lookup('ora_profile::database::version')}"
#        file:        "%{lookup('ora_profile::database::db_software::file_name')}"
#        oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home1"
#      18cORACLE_HOME2:
#        version:     "%{lookup('ora_profile::database::version')}"
#        file:        "%{lookup('ora_profile::database::db_software::file_name')}"
#        oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home2"
#      12cR1ORACLE_HOME1:
#        version:     12.1.0.2
#        file:        linuxamd64_12102_database
#        oracle_home: /u01/app/oracle/product/12.1.0.2/db_home1
#      12cR1ORACLE_HOME2:
#        version:     12.1.0.2
#        file:        linuxamd64_12102_database
#        oracle_home: /u01/app/oracle/product/12.1.0.2/db_home2
#      12cR1ORACLE_HOME3:
#        version:     12.1.0.2
#        file:        linuxamd64_12102_database
#        oracle_home: /u01/app/oracle/product/12.1.0.2/db_home3
#      12cR2ORACLE_HOME1:
#        version:      12.2.0.1
#        file:         linuxx64_12201_database
#        oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
#    ```
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
# @param [Boolean] bash_profile
#    Whether or not to deploy bash_profile for $os_user or $grid_user
#    The default is : `true`
#
# @param [String] bash_additions
#    The text to add at the end of the bash_profile.
#    This parameter will only be used when you have specified `true` for the parameter `bash_profile`
#    The default value is an empty string.
#
# @param [Stdlib::Absolutepath] user_base_dir
#    The directory to use as base directory for the users.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::db_software (
# lint:ignore:strict_indent
  String    $bash_additions,
  Boolean   $bash_profile,
  Enum['SE2', 'SE', 'EE', 'SEONE']
            $database_type,
  String[1] $dba_group,
  Array[Stdlib::Absolutepath]
            $dirs,
  String[1] $file_name,
  String[1] $oper_group,
  Stdlib::Absolutepath
            $oracle_base,
  Variant[Stdlib::Absolutepath, Hash]
            $oracle_home,
  String[1] $os_user,
  String[1] $source,
  Stdlib::Absolutepath
            $user_base_dir,
  Ora_Install::Version
            $version
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
# lint:ignore:variable_scope
  easy_type::debug_evaluation() # Show local variable on extended debug

  #
  # On non-windows systems , ensure the unzip package is installed
  #
  if !defined(Package['unzip']) and $facts['kernel'] != 'Windows' {
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
      case $facts['os']['family'] {
        'windows': {
          file { $dir:
            ensure => directory,
            owner  => $os_user,
          }
        }
        default: {
          file { $dir:
            ensure  => directory,
            owner   => $os_user,
            group   => $install_group,
            seltype => 'default_t',
            mode    => '0770',
          }
        }
      }
    }
  }

  if ( $master_node == $facts['networking']['hostname'] ) {
    if ( $is_rac ) {
      $installdb_cluster_nodes = $master_node
    } else {
      $installdb_cluster_nodes = undef
    }

    $oracle_home_defaults = {
      version                   => $version,
      file                      => $file_name,
      database_type             => $database_type,
      oracle_base               => $oracle_base,
      puppet_download_mnt_point => $source,
      bash_profile              => $bash_profile,
      bash_additions            => $bash_additions,
      group                     => $dba_group,
      group_install             => $install_group,
      group_oper                => $oper_group,
      user                      => $os_user,
      user_password             => $oracle_user_password,
      download_dir              => $download_dir,
      temp_dir                  => $temp_dir,
      cluster_nodes             => $installdb_cluster_nodes,
      ora_inventory_dir         => $ora_inventory_dir,
      user_base_dir             => $user_base_dir,
      require                   => [
        File[$dirs],
        File[$download_dir],
        Package['unzip'],
      ],
    }
    if ( $oracle_home =~ String ) {
      $install_homes = {
        $oracle_home => deep_merge($oracle_home_defaults, { oracle_home => $oracle_home }),
      }
    } else {
      if ( $is_rac ) {
        fail 'Multiple ORACLE_HOME\'s is not supported in a RAC environment yet'
      } else {
        $install_homes = $oracle_home
      }
    }

    $install_homes.each | $_home, $home_props = {} | {
      # To allow ora_profile::database::db_software::oracle_home to be a full definition
      # of the home incuding patch level, we remove the level key here. This is because 
      # ora_install::installdb doesn't know what to do with it and throws an error
      # if it is available.
      $oracle_home_props = deep_merge($oracle_home_defaults, $home_props.delete('level'))

      echo { "Ensure DB software ${oracle_home_props['version']} ${oracle_home_props['database_type']} in ${oracle_home_props['oracle_home']}":
        withpath => false,
      }

      ora_install::installdb { $oracle_home_props['oracle_home']:
        * => $oracle_home_props,
      }
  } } else {
    if ( $oracle_home =~ Hash ) {
      fail 'Multiple ORACLE_HOME\'s is not supported in a RAC environment yet'
    }

    unless $oracle_home in $facts['ora_install_homes']['product_version'].keys {
      echo { "This is not the master node. Clone ORACLE_HOME from ${master_node}":
        withpath => false,
      }

      case $version {
        '12.2.0.1', '18.0.0.0', '19.0.0.0', '21.0.0.0': {
          $add_node_command = "${oracle_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\""
        }
        '12.1.0.2': {
          $add_node_command = "${oracle_home}/addnode/addnode.sh -silent -ignorePrereq \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['networking']['hostname']}-vip}\""
        }
        '11.2.0.4': {
          $add_node_command = "IGNORE_PREADDNODE_CHECKS=Y ${oracle_home}/oui/bin/addNode.sh -ignorePrereq \"CLUSTER_NEW_NODES={${facts['networking']['hostname']}}\" \"CLUSTER_NEW_VIRTUAL_HOSTNAMES={${facts['networking']['hostname']}-vip}\""
        }
        default: {
          notice('Version not supported yet')
        }
      }

      exec { 'add_oracle_node':
        timeout => 0,
        user    => $os_user,
        umask   => '0022',
        command => "/usr/bin/ssh ${os_user}@${master_node} \"${add_node_command}\"",
        creates => "${oracle_home}/root.sh",
      }

      ~> exec { 'register_oracle_node':
        refreshonly => true,
        timeout     => 0,
        user        => 'root',
        command     => "/bin/sh ${$ora_inventory_dir}/oraInventory/orainstRoot.sh;/bin/sh ${oracle_home}/root.sh",
      }

      ~> exec { 'asmgidwrap':
        refreshonly => true,
        command     => "${grid_home}/bin/setasmgidwrap o=${oracle_home}/bin/oracle",
        user        => $grid_user,
      }
    }
  }

  if ( $facts['os']['family'] == 'windows' ) {
    file { "${oracle_base}\\admin":
      ensure => 'directory',
      owner  => $os_user,
    }
  } else {
    file { "${oracle_base}/admin":
      ensure => 'directory',
      owner  => $os_user,
      group  => $install_group,
      mode   => '0775',
    }
  }
}
# lint:endignore
