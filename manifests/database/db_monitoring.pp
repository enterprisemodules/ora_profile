#
# ora_profile::database::db_monitoring
#
# @summary This class contains the definition of the db monitoring facility to install.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Optional[Stdlib::Absolutepath]] data_path
#    The directory where you want to store the data of the facility.
#    For oswbb this will default to the archive directory inside the directory that is extracted from the file_name.
#    The default value is: undef
#
# @param [Enum['oswbb', 'ahf']] facility
#    The facility you want to install.
#    Currrently only OSWatcher Black Box (oswbb) is supported, Autonomous Health Framework (ahf) soon to come.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_monitoring::facility: oswbb
#    ```
#
# @param [String[1]] file_name
#    The file_name that contains the facility you want to install.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_monitoring::file_name: oswbb840.tar
#    ```
#
# @param [Stdlib::Absolutepath] install_path
#    The directory where you want to install the facility.
#    The default value is: '/u01'
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] oswbb_compress
#    The utility that will be used to compress the data.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_monitoring::oswbb_compress: gzip
#    ```
#
# @param [Integer] oswbb_days
#    The number of days the data will be kept in the data_path.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_monitoring::oswbb_days: 2
#    ```
#
# @param [Integer] oswbb_interval
#    The interval at which the facility will gather a snapshot in seconds.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_monitoring::oswbb_interval: 30
#    ```
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::db_monitoring (
# lint:ignore:strict_indent
  Enum['oswbb', 'ahf']
            $facility,
  String[1] $file_name,
  Stdlib::Absolutepath
            $install_path,
  String[1] $os_user,
  String[1] $oswbb_compress,
  Integer   $oswbb_days,
  Integer   $oswbb_interval,
  Optional[Stdlib::Absolutepath]
            $data_path = undef,
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
# lint:ignore:variable_scope lint:ignore:strict_indent

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { "Ensure DB monitoring facility ${facility} is installed and running":
    withpath => false,
  }

  $exec_path = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  case $facility {
    'oswbb': {
      if $data_path {
        $data_path_var = $data_path
      } else {
        $data_path_var = './archive'
      }
      archive { "${download_dir}/${file_name}":
        ensure       => present,
        cleanup      => true,
        creates      => "${install_path}/oswbb",
        extract      => true,
        extract_path => $install_path,
        group        => $install_group,
        user         => 'root',
        source       => "${source}/${file_name}",
      }
      if $data_path {
        file { $data_path:
          ensure => directory,
          owner  => $os_user,
          group  => $install_group,
          before => File['/etc/systemd/system/oswatcher.service'],
        }
      }
      include 'systemd'
      systemd::unit_file { 'oswatcher.service':
        content => epp('ora_profile/oswatcher.service.epp', {
            install_path   => $install_path,
            data_path      => $data_path_var,
            os_user        => $os_user,
            oswbb_interval => $oswbb_interval,
            oswbb_days     => $oswbb_days,
            oswbb_compress => $oswbb_compress,
        }),
      }
      ~> service { 'oswatcher':
        ensure => running,
        enable => true,
      }
    }
    'ahf': {
      echo { 'AHF will be supported soon':
        withpath => false,
      }
    }
    default: {
      echo { 'Currently the only facility supported is oswbb':
        withpath => false,
      }
    }
  }
}
# lint:endignore
