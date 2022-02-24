#
# ora_profile::client::software
#
# @summary Installs the Oracle client software on your system.
# Using this classe you can install the Oracle client software on your system.
#
# @param [Ora_install::Version] version
#    The version that is installed in the used Oracle home.
#    Puppet uses this value to decide on version specific actions.
#
# @param [String[1]] file
#    The source file to use.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    A directory to be used as Oracle home directory for this software.
#
# @param [Integer] db_port
#    The IP port to use for database communication.
#    The default value is: `1521`
#
# @param [String[1]] user
#    The user used for the specified installation.
#    The install class will not create the user for you. You must do that yourself.
#    The default value is: `oracle`
#
# @param [Stdlib::Absolutepath] user_base_dir
#    The directory to use as base directory for the users.
#
# @param [String[1]] group
#    The os group to use for these Oracle puppet definitions.
#    The default value is: `dba`
#
# @param [String[1]] group_install
#    The os group to use for installation.
#    The default value is: `oinstall`
#
# @param [Stdlib::Absolutepath] download_dir
#    The directory where the Puppet software puts all downloaded files.
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#    The default value is: `/install`
#
# @param [Stdlib::Absolutepath] temp_dir
#    Directory to use for temporary files.
#
# @param [Enum['Administrator', 'Runtime', 'InstantClient', 'Custom']] install_type
#    Which type of client software should be installed.
#
# @param [Optional[Array[String]]] install_options
#    List of Client Components you would like to install.
#    This property is considered only if INSTALL_TYPE is set to "Custom"
#
# @param [Optional[String[1]]] puppet_download_mnt_point
#    The base path of all remote files for the defined type or class.
#    The default value is: `puppet:///modules/ora_install`
#
# @param [Boolean] bash_profile
#    Create a bash profile for the specified user or not.
#    Valid values are `true` and `false`.
#    When you specify a `true` for the parameter, Puppet will create a standard bash profile for the specified user. The bash profile will be placed in a directory named `user_base_dir/user`.
#    ```puppet
#    ora_install::client { 'Oracle client':
#      ...
#      bash_profile  => true,
#      user          => 'oracle',
#      user_base_dir => '/home',
#      ...
#    }
#    ```
#    This snippet will create a bash profile called `/home/oracle/.bash_profile`.
#
# @param [Optional[Stdlib::Absolutepath]] ora_inventory_dir
#    The directory that contains the oracle inventory.
#    The default value is: `/oracle_base/oraInventory`
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
# @param [Boolean] allow_insecure
#    Allow insecure SSL connection for downloading the software.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::client::software (
  Boolean                             $allow_insecure,
  Boolean                             $bash_profile,
  Integer                             $db_port,
  Stdlib::Absolutepath                $download_dir,
  String[1]                           $file,
  String[1]                           $group,
  String[1]                           $group_install,
  Optional[Array[String]]             $install_options,
  Enum['Administrator','Runtime','InstantClient','Custom']
  $install_type,
  Variant[Boolean,Enum['on_failure']] $logoutput,
  Optional[Stdlib::Absolutepath]      $ora_inventory_dir,
  Stdlib::Absolutepath                $oracle_base,
  Stdlib::Absolutepath                $oracle_home,
  Optional[String[1]]                 $puppet_download_mnt_point,
  Stdlib::Absolutepath                $temp_dir,
  String[1]                           $user,
  Stdlib::Absolutepath                $user_base_dir,
  Ora_install::Version                $version
) {
  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { "Ensure Client Software ${version} in ${oracle_home}":
    withpath => false,
  }
  ora_install::client { "Install client ${version} into ${oracle_home}":
    version                   => $version,
    file                      => $file,
    oracle_base               => $oracle_base,
    oracle_home               => $oracle_home,
    db_port                   => $db_port,
    user                      => $user,
    user_base_dir             => $user_base_dir,
    group                     => $group,
    group_install             => $group_install,
    download_dir              => $download_dir,
    temp_dir                  => $temp_dir,
    install_type              => $install_type,
    puppet_download_mnt_point => $puppet_download_mnt_point,
    install_options           => $install_options,
    bash_profile              => $bash_profile,
    ora_inventory_dir         => $ora_inventory_dir,
    logoutput                 => $logoutput,
    allow_insecure            => $allow_insecure,
  }
}
