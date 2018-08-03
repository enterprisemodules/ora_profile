#++--++
#
# ora_profile::db_definition
#
# @summary This class contains the actual database definition using the `ora_database` type.
# Here you can customize some of the attributes of your database.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['12.2.0.1', '12.1.0.1', '12.1.0.2', '11.2.0.3', '11.2.0.4', '11.2.0.1']] version
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
class ora_profile::database::db_definition(
  Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.3','11.2.0.4', '11.2.0.1']
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
  String[1] $init_ora_template,
) inherits ora_profile::database {

  echo {"Ensure DB definition for database ${dbname} in ${oracle_home}":
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
    oracle_user                  => $os_user,
    install_group                => $install_group,
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
    provider                => $ora_profile::database::db_control_provider,
    oracle_product_home_dir => $oracle_home,
    os_user                 => $os_user,
  }

}
