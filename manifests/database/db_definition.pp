# ora_profile::database::db_definition
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_definition
class ora_profile::database::db_definition(
  Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.3','11.2.0.4', '11.2.0.1']
            $version,
  Stdlib::Absolutepath
            $oracle_home,
  Stdlib::Absolutepath
            $oracle_base,
  String[1] $dbname,
  String[1] $log_size,
  String[1] $user_tablespace_size,
  String[1] $system_tablespace_size,
  String[1] $temporary_tablespace_size,
  String[1] $undo_tablespace_size,
  String[1] $sysaux_tablespace_size,
  String[1] $system_password,
  String[1] $sys_password,
  String[1] $init_ora_template,
) inherits ora_profile::database {

  echo {"DB definition for database ${dbname} in ${oracle_home}":
    withpath => false,
  }
  #
  # All standard values fetched in data function
  #
  ora_database{$dbname:
    ensure                       => present,
    init_ora_content             => template($init_ora_template),
    oracle_base                  => $oracle_base,
    oracle_home                  => $oracle_home,
    system_password              => $system_password,
    sys_password                 => $sys_password,
    character_set                => 'AL32UTF8',
    national_character_set       => 'AL16UTF16',
    extent_management            => 'local',
    logfile_groups               => [
        {group => 10, size => $log_size},
        {group => 10, size => $log_size},
        {group => 20, size => $log_size},
        {group => 20, size => $log_size},
        {group => 30, size => $log_size},
        {group => 30, size => $log_size},
      ],
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
    timezone                     => '+01:00',
  }
  #
  # Database is done. Now start it
  #
  ->db_control {'database started':
    ensure                  => 'start',
    provider                => 'sqlplus',
    oracle_product_home_dir => $oracle_home,
    # os_user                 => $os_user,
  }

  # -> ora_install::dbactions{ "start_${dbname}":
  #   oracle_home => $oracle_home,
  #   db_name     => $dbname,
  # }

}
