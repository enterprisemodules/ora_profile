#
# ora_profile::oem_agent::software
#
# @summary Installs Oracle Enterprse Manager Agent.
#
#
# @param [Stdlib::Absolutepath] agent_base_dir
#    The directory to use as instance home.
#
# @param [Easy_type::Password] agent_registration_password
#    The password to use to register the agent.
#
# @param [Stdlib::Absolutepath] download_dir
#    The directory where the Puppet software puts all downloaded files.
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#    The default value is: `/install`
#    To customize this consistently use the hiera key `ora_profile::database::download_dir`.
#
# @param [Integer] em_upload_port
#    The port number of the HTTP port for the upload service.
#    The default value is: `1159`
#
# @param [Boolean] install_agent
#    Flag to indicate the OEM Agent needs to be installed or not.
#    In case your OEM Server hasn't been installed yet, set this to `false`
#
# @param [String] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String] install_version
#    The version you want to install.
#    The default value is: `12.1.0.5.0`
#
# @param [String] oms_host
#    The OMS host to use.
#
# @param [Integer] oms_port
#    The IP port to use for connecting to the OMS host.
#
# @param [Stdlib::Absolutepath] ora_inventory_dir
#    The directory that contains the oracle inventory.
#    The default value is: `/oracle_base/oraInventory`
#    To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [Easy_type::Password] sysman_password
#    The password to use for sysman.
#
# @param [String] sysman_user
#    The sysman user.
#    The default value is: `sysman`
#
# @param [Stdlib::Absolutepath] temp_dir
#    Directory to use for temporary files.
#
# @param [String] version
#    The agent version to be installed
#    - `12.1.0.4`
#    - `12.1.0.5`
#    - `13.1.0.0`
#    - `13.2.0.0`
#    - `13.3.0.0`
#    - `13.4.0.0`
#    - `13.5.0.0`
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::oem_agent::software(
  String               $version,
  String               $install_version,
  String               $oms_host,
  Integer              $oms_port,
  Integer              $em_upload_port,
  String               $sysman_user,
  Easy_type::Password  $sysman_password,
  Easy_type::Password  $agent_registration_password,
  Stdlib::Absolutepath $agent_base_dir,
  Stdlib::Absolutepath $oracle_base,
  Stdlib::Absolutepath $ora_inventory_dir,
  String               $os_user,
  String               $install_group,
  Stdlib::Absolutepath $download_dir,
  Stdlib::Absolutepath $temp_dir,
  Boolean              $install_agent = true,
) inherits ora_profile::oem_agent {

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $install_agent ) {
    echo {"Ensure Enterprise Manager agent ${install_version} installation in ${agent_base_dir}/agent_${install_version}":
      withpath => false,
    }

    ora_install::installem_agent{ 'install_emagent':
      version                     => $version,
      install_type                => 'agentPull',
      install_version             => $install_version,
      install_platform            => 'Linux x86-64',
      source                      => "https://${oms_host}:${em_upload_port}/em/install/getAgentImage",
      ora_inventory_dir           => $ora_inventory_dir,
      oracle_base_dir             => $oracle_base,
      agent_base_dir              => $agent_base_dir,
      agent_instance_home_dir     => "${agent_base_dir}/agent_inst",
      agent_registration_password => $agent_registration_password,
      agent_port                  => 3872,
      sysman_user                 => $sysman_user,
      sysman_password             => $sysman_password,
      oms_host                    => $oms_host,
      oms_port                    => $oms_port,
      em_upload_port              => $em_upload_port,
      user                        => $os_user,
      group                       => $install_group,
      download_dir                => $download_dir,
      temp_dir                    => $temp_dir,
      logoutput                   => true,
    }

    -> exec{"/bin/rm ${download_dir}/em_agent.properties":
      onlyif => "/bin/stat ${download_dir}/em_agent.properties",
    }
  }
}
