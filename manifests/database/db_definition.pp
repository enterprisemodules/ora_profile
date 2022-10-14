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
# @param [Variant[String[1], Hash]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#    This parameter can also be defined as Hash in which case the key(s) of the Hash are the name of the database(s).
#    The defaults for all the database(s) in the Hash are the ones given to the db_definition class.
#    In addition all properties and parameters taken by ora_database can be defined in hiera data.
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
#    This needs to be an epp template.
#    The default value is: 'ora_profile/init.ora.epp'
#
# @param [Hash] init_ora_params
#    The parameters to use in the template specified in `init_ora_template`.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_definition::init_ora_params:
#      dbname: "%{lookup('ora_profile::database::db_definition::dbname')}"
#      dbdomain: "%{lookup('ora_profile::database::db_definition::dbdomain')}"
#      db_create_file_dest: "%{lookup('ora_profile::database::db_definition::data_file_destination')}"
#      db_recovery_file_dest: "%{lookup('ora_profile::database::db_definition::db_recovery_file_dest')}"
#      db_recovery_file_dest_size: 20480m
#      compatible: "%{lookup('ora_profile::database::db_definition::version')}"
#      oracle_base: "%{lookup('ora_profile::database::db_definition::oracle_base')}"
#      container_database: "%{lookup('ora_profile::database::db_definition::container_database')}"
#      sga_target: 1024m
#      pga_aggregate_target: 256m
#      processes: 300
#      open_cursors: 300
#      db_block_size: 8192
#      log_archive_format: '%t_%s_%r.dbf'
#      audit_trail: db
#      remote_login_passwordfile: EXCLUSIVE
#      undo_tablespace: UNDOTBS1
#      memory_target: 0
#      memory_max_target: 0
#    ```
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
# @param [Optional[String[1]]] dbdomain
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
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::db_definition (
# lint:ignore:strict_indent
# lint:ignore:lookup_in_parameter
  Enum['enabled','disabled']
            $archivelog,
  Enum['enabled','disabled']
            $container_database,
  String[1] $data_file_destination,
  String[1] $db_recovery_file_dest,
  Optional[String[1]]
            $dbdomain,
  Variant[String[1], Hash]
            $dbname,
  Hash      $init_ora_params,
  String[1] $init_ora_template,
  String[1] $install_group,
  String[1] $log_size,
  Hash      $ora_database_override,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $os_user,
  Easy_type::Password
            $sys_password,
  String[1] $sysaux_tablespace_size,
  Easy_type::Password
            $system_password,
  String[1] $system_tablespace_size,
  String[1] $temporary_tablespace_size,
  String[1] $undo_tablespace_size,
  String[1] $user_tablespace_size,
  Ora_Install::Version
            $version,
  Variant[Boolean,Enum['on_failure']]
            $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' })
) inherits ora_profile::database {
# lint:endignore:strict_indent
# lint:endignore:lookup_in_parameter
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $version == '21.0.0.0' ) {
    unless ( $container_database == 'enabled' ) {
      fail "Oracle version ${version} only supports container_database='enabled', container_database='${container_database}' specified"
    }
  }

  if ( $is_rac ) {
    if ( $dbname =~ Hash and $dbname.length > 1 ) {
      fail 'Multiple databases is not supported in a RAC environment yet'
    } elsif ( $dbname =~ String ) {
      echo { "Ensure DB definition for RAC database ${dbname} in ${oracle_home}":
        withpath => false,
      }
    } else {
      echo { "Ensure DB definition for RAC database ${dbname.keys[0]} in ${dbname['oracle_home']}":
        withpath => false,
      }
    }
  } else {
    if ( $dbname =~ Hash ) {
      $dbname.each |$db, $db_props| {
        echo { "Ensure DB definition for database ${db} in ${db_props['oracle_home']}":
          withpath => false,
        }
      }
    } else {
      echo { "Ensure DB definition for database ${dbname} in ${oracle_home}":
        withpath => false,
      }
    }
  }
  #
  # All standard values fetched in data function
  #
  if ( $is_rac ) {
    $db_cluster_nodes = { $db_instance_name => $facts['networking']['hostname'] }
  } else {
    $db_cluster_nodes = undef
  }

  $dbname_defaults = {
    ensure                    => present,
    init_ora_params           => $init_ora_params + { is_windows => $is_windows },
    # ora_database parameters below
    disable_corrective_ensure => true,
    archivelog                => $archivelog,
    oracle_base               => $oracle_base,
    oracle_home               => $oracle_home,
    oracle_user               => $os_user,
    oracle_user_password      => $oracle_user_password,
    install_group             => $install_group,
    system_password           => unwrap($system_password),
    # init_ora_content             => template($init_ora_template), # Don't include init_ora_content here, merge it later
    sys_password              => unwrap($sys_password),
    character_set             => 'AL32UTF8',
    national_character_set    => 'AL16UTF16',
    container_database        => $container_database,
    extent_management         => 'local',
    instances                 => $db_cluster_nodes,
    spfile_location           => $data_file_destination,
    logfile_groups            => case $is_rac {
      true: {
        [
          { group => 1, size => $log_size, thread => 1 },
          { group => 1, size => $log_size, thread => 1 },
          { group => 2, size => $log_size, thread => 1 },
          { group => 2, size => $log_size, thread => 1 },
          { group => 3, size => $log_size, thread => 1 },
          { group => 3, size => $log_size, thread => 1 },
          { group => 4, size => $log_size, thread => 2 },
          { group => 4, size => $log_size, thread => 2 },
          { group => 5, size => $log_size, thread => 2 },
          { group => 5, size => $log_size, thread => 2 },
          { group => 6, size => $log_size, thread => 2 },
          { group => 6, size => $log_size, thread => 2 },
        ]
      }
      default: {
        [
          { group => 10, size => $log_size },
          { group => 10, size => $log_size },
          { group => 20, size => $log_size },
          { group => 20, size => $log_size },
          { group => 30, size => $log_size },
          { group => 30, size => $log_size },
        ]
      }
    },
    datafiles                    => [
      { size => $system_tablespace_size, autoextend => { next => '10M', maxsize => 'unlimited' } },
    ],
    sysaux_datafiles             => [
      { size => $sysaux_tablespace_size, autoextend => { next => '10M', maxsize => 'unlimited' } },
    ],
    default_temporary_tablespace => {
      name     => 'TEMP',
      tempfile => {
        size       => $temporary_tablespace_size,
        autoextend => {
          next    => '5M',
          maxsize => 'unlimited',
        },
      },
    },
    undo_tablespace              => {
      name     => 'UNDOTBS1',
      datafile => {
        size       => $undo_tablespace_size,
        autoextend => { next => '5M', maxsize => 'unlimited' },
      },
    },
    default_tablespace           => {
      name              => 'USERS',
      datafile          => {
        size       => $user_tablespace_size,
        autoextend => { next => '1M', maxsize => 'unlimited' },
      },
      extent_management => {
        'type'       => 'local',
        autoallocate => true,
      },
    },
    timezone                     => 'Europe/Amsterdam',
  }

  if ( $dbname =~ String ) {
    $database = case $ora_database_override.empty {
      false: {
        { $dbname => deep_merge($dbname_defaults, $ora_database_override) }
      }
      default: {
        { $dbname => $dbname_defaults }
      }
    }
  } else {
    $database = $dbname.map |$db, $db_props| {{ $db => deep_merge($dbname_defaults, $db_props) } }.reduce({}) |$memo, $array| { $memo + $array }
  }

  if ( $master_node == $facts['networking']['hostname'] ) {
    $database.each |$db, $db_props| {
      if ( has_key($db_props, 'container_database') ) {
        $cdb_prop = { container_database => $db_props['container_database'] }
      } else {
        $cdb_prop = { container_database => $container_database }
      }
      $init_ora = { init_ora_content => epp($init_ora_template, $db_props['init_ora_params'] + $cdb_prop) }
      # Add init_ora_content to hash and remove init_ora_params, which is only needed for the init_ora_content
      $all_db_props = $db_props + $init_ora - init_ora_params

      ora_database { $db:
        * => $all_db_props,
      }

      if ( $db_props['ensure'] == present ) {
        #
        # Database is done. Now start it
        #
        db_control { "database ${db} started from ${all_db_props['oracle_home']}":
          ensure                  => 'start',
          provider                => $db_control_provider,
          instance_name           => $db,
          oracle_product_home_dir => $all_db_props['oracle_home'],
          require                 => Ora_database[$db],
        }
      }
    }
  } else {
    $database.each |$db, $db_props| {
      $all_db_props = $db_props  - init_ora_params
      $instance_name = set_param('instance_name', $db, $cluster_nodes)
      $oh = $all_db_props['oracle_home']
      if ( $db_props['ensure'] == present ) {
        file { "${oh}/dbs/init${instance_name}.ora":
          ensure  => file,
          content => "spfile='${data_file_destination}/spfile${db}.ora'",
        }

        -> exec { "add instance ${db}":
          user        => $os_user,
          environment => ["ORACLE_SID=${instance_name}", 'ORAENV_ASK=NO', "ORACLE_HOME=${oh}"],
          command     => "${oh}/bin/srvctl add instance -d ${db} -i ${instance_name} -n ${facts['networking']['hostname']}",
          unless      => "${oh}/bin/srvctl status instance -d ${db} -i ${instance_name}",
          logoutput   => $logoutput,
        }

        -> exec { "start instance ${db}":
          user        => $os_user,
          environment => ["ORACLE_SID=${instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oh}"],
          command     => "${oh}/bin/srvctl start instance -d ${db} -i ${instance_name}",
          onlyif      => "${oh}/bin/srvctl status instance -d ${db} -i ${instance_name} | grep not",
          logoutput   => $logoutput,
        }

        -> ora_setting { $instance_name:
          default     => true,
          oracle_home => $oh,
          cdb         => case $container_database {
            'enabled': {
              true
            }
            default: {
              false
            }
          },
        }

        -> ora_tab_entry { $instance_name:
          ensure      => 'present',
          oracle_home => $oh,
          startup     => 'Y',
          comment     => 'Oracle instance added by Puppet',
        }

        -> ora_database { $db:
          * => $all_db_props,
        }
      } else {
        ora_database { $db:
          * => $all_db_props,
        }
      }
    }
  }

  if ( $is_rac ) {
    $database.each |$db, $db_props| {
      $oh = $db_props['oracle_home']
      $cluster_nodes.each |$index, $node| {
        $instance_name = set_param('instance_name', $db, $cluster_nodes)
        $inst_number = $index + 1
        ora_profile::database::rac::instance { "${db}${inst_number}":
          on                => $instance_name,
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
        # exec {"create pfile for ${db}${instance_number}":
        #   command     => "echo -e \"set heading off\nselect 'spfile='''||value||'''' from v\\\$parameter where name = 'spfile';\" | ${oh}/bin/sqlplus -S / as sysdba | grep -v ^\$ > ${oracle_home}/dbs/init${db}${instance_number}.ora",
        #   cwd         => '/tmp',
        #   environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oh}"],
        #   path        => '/bin',
        #   user        => $ora_profile::database::os_user,
        #   unless      => "stat ${oh}/dbs/init${db}${instance_number}.ora",
        # }
      }
    }
  }
}
# lint:endignore
