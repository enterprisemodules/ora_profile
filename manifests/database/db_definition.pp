#++--++
#
# ora_profile::db_definition
#
# @summary This class contains the actual database definition using the `ora_database` type.
# Here you can customize some of the attributes of your database.
# 
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
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
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
# @param [String[1]] system_password
#    The `system` password to use for the database.
#    The default value is: `Welcome01`
#
# @param [String[1]] sys_password
#    The `sys` password to use for the database.
#    The default value is: `Change_on_1nstall`
#
# @param [String[1]] init_ora_template
#    The template to use for the init.
#    ora parameters.
#    The default value is: 'ora_profile/init.ora.erb'
#
#--++--
# lint:ignore:variable_scope
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
  String[1] $system_password,
  String[1] $sys_password,
  Enum['enabled','disabled']
            $container_database,
  Enum['enabled','disabled']
            $archivelog,
  String[1] $init_ora_template,
  String[1] $data_file_destination,
  String[1] $db_recovery_file_dest,
) inherits ora_profile::database {

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
    ora_database {$dbname:
      ensure                       => present,
      disable_corrective_ensure    => true,
      archivelog                   => $archivelog,
      init_ora_content             => template($init_ora_template),
      oracle_base                  => $oracle_base,
      oracle_home                  => $oracle_home,
      oracle_user                  => $os_user,
      oracle_user_password         => $oracle_user_password,
      install_group                => $install_group,
      system_password              => $system_password,
      sys_password                 => $sys_password,
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
    exec {'add_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO', "ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl add instance -d ${dbname} -i ${db_instance_name} -n ${::hostname}",
      unless      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name}",
      logoutput   => on_failure,
    }

    -> exec {'start_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl start instance -d ${dbname} -i ${db_instance_name}",
      onlyif      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name} | grep not",
      logoutput   => on_failure,
    }

    -> ora_setting { $db_instance_name:
      default     => true,
      oracle_home => $oracle_home,
    }

    -> ora_database {$dbname:
      ensure                    => present,
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
        undo_initial_size => '100M',
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
