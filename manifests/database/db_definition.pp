#++--++
#
# ora_profile::database::db_definition
#
# @summary This class contains the actual database definition using the `ora_database` type.
# Here you can customize some of the attributes of your database.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Ora_Install::Version] version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [String[1]] log_size
#    The log ize to use.
#    The default is : `100M`
#
# @param [String[1]] user_tablespace_size
#    The size for the `USER` tablespace.
#    The default value is `50M`
#
# @param [String[1]] system_tablespace_size
#    The size for the `SYSTEM` tablespace.
#    The default value is `50M`
#
# @param [String[1]] temporary_tablespace_size
#    The size for the `TEMP` tablespace.
#    The default value is `50M`
#
# @param [String[1]] undo_tablespace_size
#    The size for the `UNDO` tablespace.
#    The default value is `50M`
#
# @param [String[1]] sysaux_tablespace_size
#    The size for the `SYSAUX` tablespace.
#    The default value is `50M`
#
# @param [Easy_type::Password] system_password
#    The `system` password to use for the database.
#    The default value is: `Welcome01`
#
# @param [Easy_type::Password] sys_password
#    The `sys` password to use for the database.
#    The default value is: `Change_on_1nstall`
#
# @param [Enum['enabled', 'disabled']] container_database
#    Database is a container for pluggable databases.
#    When you want to add pluggable database to this database, specify a value of `enabled`.
#    The default value is: `disabled`
#
# @param [Enum['enabled', 'disabled']] archivelog
#    The database should be running in archivelog mode.
#
# @param [String[1]] init_ora_template
#    The template to use for the init.
#    ora parameters.
#    The default value is: 'ora_profile/init.ora.erb'
#
# @param [String[1]] data_file_destination
#    The location of the datafiles.
#
# @param [String[1]] db_recovery_file_dest
#    The location of the Flash Recovery Area.
#
# @param [Hash] ora_database_override
#    A hash with database settings that will override the default database settings.
#
# @param [String[1]] dbdomain
#    The domain of the database.
#    The default is `$facts['networking']['domain']`
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
#--++--
class ora_profile::database::db_definition(
  Ora_Install::Version
            $version,
  Stdlib::Absolutepath
            $oracle_home,
  Stdlib::Absolutepath
            $oracle_base,
  String[1] $os_user,
  String[1] $install_group,
  String[1] $dbname,
  String[1] $log_size,
  String[1] $user_tablespace_size,
  String[1] $system_tablespace_size,
  String[1] $temporary_tablespace_size,
  String[1] $undo_tablespace_size,
  String[1] $sysaux_tablespace_size,
  Easy_type::Password
            $system_password,
  Easy_type::Password
            $sys_password,
  Enum['enabled','disabled']
            $container_database,
  Enum['enabled','disabled']
            $archivelog,
  String[1] $init_ora_template,
  String[1] $data_file_destination,
  String[1] $db_recovery_file_dest,
  Hash      $ora_database_override,
  String[1] $dbdomain,
  Variant[Boolean,Enum['on_failure']]
            $logoutput = lookup({name => 'logoutput', default_value => 'on_failure'}),
) inherits ora_profile::database {
# lint:ignore:variable_scope

  if ( $is_rac ) {
    echo {"Ensure DB definition for RAC database ${dbname} in ${oracle_home}":
      withpath => false,
    }
  } else {
    echo {"Ensure DB definition for database ${dbname} in ${oracle_home}":
      withpath => false,
    }
  }
  #
  # All standard values fetched in data function
  #
  $split_version = split($version, '[.]')
  $db_version = "${split_version[0]}.${split_version[1]}"
  if ( $is_rac ) {
    $db_cluster_nodes = { $db_instance_name => $facts['hostname'] }
  } else {
    $db_cluster_nodes = undef
  }

  if ( $master_node == $facts['hostname'] ) {

    $ora_database_settings = {
      disable_corrective_ensure    => true,
      archivelog                   => $archivelog,
      init_ora_content             => template($init_ora_template),
      oracle_base                  => $oracle_base,
      oracle_home                  => $oracle_home,
      oracle_user                  => $os_user,
      oracle_user_password         => $oracle_user_password,
      install_group                => $install_group,
      system_password              => unwrap($system_password),
      sys_password                 => unwrap($sys_password),
      character_set                => 'AL32UTF8',
      national_character_set       => 'AL16UTF16',
      container_database           => $container_database,
      extent_management            => 'local',
      instances                    => $db_cluster_nodes,
      spfile_location              => $data_file_destination,
      logfile_groups               => case $is_rac {
        true: {
          [
            {group => 1, size => $log_size, thread => 1},
            {group => 1, size => $log_size, thread => 1},
            {group => 2, size => $log_size, thread => 1},
            {group => 2, size => $log_size, thread => 1},
            {group => 3, size => $log_size, thread => 1},
            {group => 3, size => $log_size, thread => 1},
            {group => 4, size => $log_size, thread => 2},
            {group => 4, size => $log_size, thread => 2},
            {group => 5, size => $log_size, thread => 2},
            {group => 5, size => $log_size, thread => 2},
            {group => 6, size => $log_size, thread => 2},
            {group => 6, size => $log_size, thread => 2},
          ]
        }
        default: {
          [
            {group => 10, size => $log_size},
            {group => 10, size => $log_size},
            {group => 20, size => $log_size},
            {group => 20, size => $log_size},
            {group => 30, size => $log_size},
            {group => 30, size => $log_size},
          ]
        }
      },
      datafiles                    => [
        {size => $system_tablespace_size, autoextend => {next => '10M', maxsize => 'unlimited'}},
      ],
      sysaux_datafiles             => [
        {size => $sysaux_tablespace_size, autoextend => {next => '10M', maxsize => 'unlimited'}},
      ],
      default_temporary_tablespace => {
        name     => 'TEMP',
        tempfile => {
          size       => $temporary_tablespace_size,
          autoextend => {
            next    => '5M',
            maxsize => 'unlimited',
          }
        },
      },
      undo_tablespace              => {
        name     => 'UNDOTBS1',
        datafile => {
          size       => $undo_tablespace_size,
          autoextend => {next => '5M', maxsize => 'unlimited'}      }
      },
      default_tablespace           => {
        name              => 'USERS',
        datafile          => {
          size       => $user_tablespace_size,
          autoextend => {next => '1M', maxsize => 'unlimited'}
        },
        extent_management => {
          'type'       => 'local',
          autoallocate => true,
        }
      },
      timezone                     => 'Europe/Amsterdam',
    }.deep_merge($ora_database_override)

    ora_database {$dbname:
      ensure => present,
      *      => $ora_database_settings,
    }

    #
    # Database is done. Now start it
    #
    -> db_control {'database started':
      ensure                  => 'start',
      provider                => $db_control_provider,
      instance_name           => $dbname,
      oracle_product_home_dir => $oracle_home,
    }
  } else {

    $ora_database_settings = {
      disable_corrective_ensure => true,
      archivelog                => $archivelog,
      instances                 => $db_cluster_nodes,
      logfile_groups            => case $is_rac {
        true: {
          [
            {group => 1, size => $log_size, thread => 1},
            {group => 1, size => $log_size, thread => 1},
            {group => 2, size => $log_size, thread => 1},
            {group => 2, size => $log_size, thread => 1},
            {group => 3, size => $log_size, thread => 1},
            {group => 3, size => $log_size, thread => 1},
            {group => 4, size => $log_size, thread => 2},
            {group => 4, size => $log_size, thread => 2},
            {group => 5, size => $log_size, thread => 2},
            {group => 5, size => $log_size, thread => 2},
            {group => 6, size => $log_size, thread => 2},
            {group => 6, size => $log_size, thread => 2},
          ]
        }
        default: {
          [
            {group => 10, size => $log_size},
            {group => 10, size => $log_size},
            {group => 20, size => $log_size},
            {group => 20, size => $log_size},
            {group => 30, size => $log_size},
            {group => 30, size => $log_size},
          ]
        }
      },
    }.deep_merge($ora_database_override)

    file { "${oracle_home}/dbs/init${db_instance_name}.ora":
      ensure  => present,
      content => "spfile='${data_file_destination}/spfile${dbname}.ora'"
    }

    -> exec {'add_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO', "ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl add instance -d ${dbname} -i ${db_instance_name} -n ${::hostname}",
      unless      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name}",
      logoutput   => $logoutput,
    }

    -> exec {'start_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl start instance -d ${dbname} -i ${db_instance_name}",
      onlyif      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name} | grep not",
      logoutput   => $logoutput,
    }

    -> ora_setting { $db_instance_name:
      default     => true,
      oracle_home => $oracle_home,
      cdb         => case $container_database {
        'enabled': {
          true
        }
        default: {
          false
        }
      },
    }

    -> ora_tab_entry{ $db_instance_name:
      ensure      => 'present',
      oracle_home => $oracle_home,
      startup     => 'Y',
      comment     => 'Oracle instance added by Puppet',
    }

    -> ora_database {$dbname:
      ensure => present,
      *      => $ora_database_settings,
    }
  }

  if ( $is_rac ) {
    $cluster_nodes.each |$index, $node| {
      $inst_number = $index + 1
      ora_profile::database::rac::instance {"${dbname}${inst_number}":
        on                => $db_instance_name,
        number            => $inst_number,
        thread            => $inst_number,
        datafile          => $data_file_destination,
        undo_initial_size => $undo_tablespace_size,
        undo_next         => '100M',
        undo_autoextend   => 'on',
        undo_max_size     => 'unlimited',
        log_size          => $log_size,
      }

      ## Might be needed for older versions
      # exec {"create pfile for ${dbname}${instance_number}":
      #   command     => "echo -e \"set heading off\nselect 'spfile='''||value||'''' from v\\\$parameter where name = 'spfile';\" | ${oracle_home}/bin/sqlplus -S / as sysdba | grep -v ^\$ > ${oracle_home}/dbs/init${dbname}${instance_number}.ora",
      #   cwd         => '/tmp',
      #   environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oracle_home}"],
      #   path        => '/bin',
      #   user        => $ora_profile::database::os_user,
      #   unless      => "stat ${oracle_home}/dbs/init${dbname}${instance_number}.ora",
      # }
    }
  }
}
# lint:endignore
