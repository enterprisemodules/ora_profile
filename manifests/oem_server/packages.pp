#++--++
#
# ora_profile::oem_server::packages
#
# @summary This class contains the definition of the packages you need to have installed on your system.
#
#
# @param [Hash] list
#    The required packages for a succesfull Oracle Enterprise Manager installation.
#    The defaults are:
#    ```yaml
#    ora_profile::oem_server::packages::list:
#      gcc: {}
#      gcc-c++: {}
#      dejavu-serif-fonts: {}
#      numactl: {}
#      numactl-devel: {}
#      motif: {}
#      motif-devel: {}
#      redhat-lsb: {}
#      redhat-lsb-core: {}
#      openssl: {}
#    ```
#
#--++--
class ora_profile::oem_server::packages(
  Hash $list,
) inherits ora_profile::oem_server {

  if ( $ora_profile::oem_server::standalone ) {
    $db_packages = lookup('ora_profile::database::packages::list')
    $package_list = deep_merge($db_packages, $list)
  } else {
    $package_list = $list
  }

  if $package_list.size > 0 {
    $packages = $package_list.keys
    echo {"Ensure OEM Packages(s) ${packages.join(',')}":
      withpath => false,
    }
  }

  ensure_packages($package_list)
}
