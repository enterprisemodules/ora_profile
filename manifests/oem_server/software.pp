#
# ora_profile::oem_server::software
#
# @summary Installs Oracle Enterprse Manager.
#
#
# @param [Stdlib::Absolutepath] agent_base_dir
#    The directory to use as base for the agent software.
#
# @param [Easy_type::Password] agent_registration_password
#    The password to use to register the agent.
#
# @param [String[1]] database_hostname
#    The DNS name of the database host.
#
# @param [Integer] database_listener_port
#    The IP port for the database listener.
#    The default value is: `1521`
#
# @param [String[1]] database_service_sid_name
#    The database service SID name for the database.
#
# @param [Easy_type::Password] database_sys_password
#    The password of the SYS user of the database.
#
# @param [String[1]] deployment_size
#    The size of the deployment.
#    Valid values are:
#    - `SMALL`
#    - `MEDIUM`
#    - `LARGE`
#    The default value is: `SMALL`
#
# @param [Stdlib::Absolutepath] download_dir
#    The directory where the Puppet software puts all downloaded files.
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#    The default value is: `/install`
#    To customize this consistently use the hiera key `ora_profile::database::download_dir`.
#
# @param [String[1]] file
#    The source file to use.
#
# @param [String[1]] group
#    The dba group for ASM.
#    The default is : `asmdba`
#    To customize this consistently use the hiera key `ora_profile::database::asm_software::group`.
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
# @param [Stdlib::Absolutepath] ora_inventory_dir
#    The directory that contains the oracle inventory.
#    The default value is: `/oracle_base/oraInventory`
#    To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.
#
# @param [Stdlib::Absolutepath] oracle_base_dir
#    A directory to use as Oracle base directory.
#
# @param [Stdlib::Absolutepath] oracle_home_dir
#    A directory to be used as Oracle home directory for this software.
#
# @param [String[1]] puppet_download_mnt_point
#    Where to get the source of your template from.
#    This is the module where the xml file for your template is stored as a puppet template(erb).
#    The default value is `ora_profile`
#
# @param [Stdlib::Absolutepath] software_library_dir
#    The directory to use for the software library.
#
# @param [Boolean] swonly
#    Only install the software without configuration (true) or not (false).
#    The default value is: `false`
#
# @param [Easy_type::Password] sysman_password
#    The password to use for sysman.
#
# @param [Stdlib::Absolutepath] temp_dir
#    Directory to use for temporary files.
#
# @param [String[1]] user
#    The user used for the specified installation.
#    The install class will not create the user for you. You must do that yourself.
#    The default value is: `oracle`
#
# @param [String[1]] version
#    The server version to be installed
#    - `12.1.0.4`
#    - `12.1.0.5`
#    - `13.1.0.0`
#    - `13.2.0.0`
#    - `13.3.0.0`
#    - `13.4.0.0`
#    - `13.5.0.0`
#
# @param [Easy_type::Password] weblogic_password
#    The password to use for WebLogic.
#
# @param [String[1]] weblogic_user
#    The username to use for WebLogic.
#    The default value is: `weblogic`
#
# @param [Boolean] zip_extract
#    The specified source file is a zip file that needs te be extracted.
#    When you specify a value of false, the source attribute must contain a reference to a directory instead of a zip file.
#    The default value is: `true`
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::oem_server::software(
  String[1]                           $version,
  String[1]                           $file,
  Stdlib::Absolutepath                $oracle_base_dir,
  Stdlib::Absolutepath                $oracle_home_dir,
  Stdlib::Absolutepath                $agent_base_dir,
  Stdlib::Absolutepath                $software_library_dir,
  Stdlib::Absolutepath                $ora_inventory_dir,
  String[1]                           $weblogic_user,
  Easy_type::Password                 $weblogic_password,
  String[1]                           $database_hostname,
  Integer                             $database_listener_port,
  String[1]                           $database_service_sid_name,
  Easy_type::Password                 $database_sys_password,
  Easy_type::Password                 $sysman_password,
  Easy_type::Password                 $agent_registration_password,
  String[1]                           $deployment_size,
  String[1]                           $user,
  String[1]                           $group,
  Stdlib::Absolutepath                $download_dir,
  Stdlib::Absolutepath                $temp_dir,
  Boolean                             $zip_extract,
  String[1]                           $puppet_download_mnt_point,
  Variant[Boolean,Enum['on_failure']] $logoutput,
  Boolean                             $swonly,
) inherits ora_profile::oem_server {

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo {"Ensure OEM Server version ${version} in ${oracle_home_dir}":
    withpath => false,
  }

  unless ( $ora_profile::oem_server::standalone ) {
    $dbname = $database_service_sid_name.split('\.')[0]
    if ( ora_install::oracle_exists( $oracle_home_dir ) ) {
      ora_autotask { $dbname:
        auto_optimizer_stats_collection => 'enabled',
      }
    } else {
      ora_autotask { $dbname:
        auto_optimizer_stats_collection => 'disabled',
      }
      # Restart the database to effectuate the changed init params
      $db_home = lookup('ora_profile::database::oracle_home')
      $db_os_user = lookup('ora_profile::database::os_user')
      $db_control_provider = lookup('ora_profile::database::db_control_provider')
      db_control {"stop database ${dbname}":
        ensure                  => 'stop',
        instance_name           => $dbname,
        oracle_product_home_dir => $db_home,
        os_user                 => $db_os_user,
        provider                => $db_control_provider,
        before                  => Db_control["start database ${dbname}"],
      }
      db_control {"start database ${dbname}":
        ensure                  => 'start',
        instance_name           => $dbname,
        oracle_product_home_dir => $db_home,
        os_user                 => $db_os_user,
        provider                => $db_control_provider,
        require                 => Db_control["stop database ${dbname}"],
      }

    }
  }

  ora_install::installem{ "Install Enterprise Manager ${version}":
    version                     => $version,
    file                        => $file,
    oracle_base_dir             => $oracle_base_dir,
    oracle_home_dir             => $oracle_home_dir,
    agent_base_dir              => $agent_base_dir,
    software_library_dir        => $software_library_dir,
    ora_inventory_dir           => $ora_inventory_dir,
    weblogic_user               => $weblogic_user,
    weblogic_password           => $weblogic_password,
    database_hostname           => $database_hostname,
    database_listener_port      => $database_listener_port,
    database_service_sid_name   => $database_service_sid_name,
    database_sys_password       => $database_sys_password,
    sysman_password             => $sysman_password,
    agent_registration_password => $agent_registration_password,
    deployment_size             => $deployment_size,
    user                        => $user,
    group                       => $group,
    download_dir                => $download_dir,
    temp_dir                    => $temp_dir,
    zip_extract                 => $zip_extract,
    puppet_download_mnt_point   => $puppet_download_mnt_point,
    logoutput                   => $logoutput,
    swonly                      => $swonly,
  }
}
