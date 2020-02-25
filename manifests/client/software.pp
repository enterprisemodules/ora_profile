#++--++
#
# ora_profile::client::software
#
# @summary This class contains the code to install Oracle client sofware
#
#--++--
class ora_profile::client::software(
  Ora_install::Version                $version,
  String[1]                           $file,
  Stdlib::Absolutepath                $oracle_base,
  Stdlib::Absolutepath                $oracle_home,
  Integer                             $db_port,
  String[1]                           $user,
  Stdlib::Absolutepath                $user_base_dir,
  String[1]                           $group,
  String[1]                           $group_install,
  Stdlib::Absolutepath                $download_dir,
  Stdlib::Absolutepath                $temp_dir,
  Enum['Administrator','Runtime','InstantClient','Custom']
                                      $install_type,
  Optional[Array[String]]             $install_options,
  Optional[String[1]]                 $puppet_download_mnt_point,
  Boolean                             $bash_profile,
  Optional[Stdlib::Absolutepath]      $ora_inventory_dir,
  Variant[Boolean,Enum['on_failure']] $logoutput,
  Boolean                             $allow_insecure,
){

  echo {"Ensure Client Software ${version} in ${oracle_home}":
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
