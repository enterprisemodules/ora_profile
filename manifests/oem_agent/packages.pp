#++--++
#
# ora_profile::oem_agent::packages
#
# @summary This class contains the definition of the packages you need to have installed on your system.
#
#
# @param [Hash] list
#    The required packages for a succesfull Oracle Enterprise Manager Agent installation.
#    The defaults are:
#    ```yaml
#    ora_profile::oem_agent::packages::list:
#      make: {}
#      binutils: {}
#      gcc: {}
#      libaio: {}
#      glibc-common: {}
#      libstdc++: {}
#      sysstat: {}
#    ```
#
#--++--
class ora_profile::oem_agent::packages(
  Hash $list,
) inherits ora_profile::oem_agent {

  if $list.size > 0 {
    $packages = $list.keys
    echo {"Ensure OEM Agent Packages(s) ${packages.join(',')}":
      withpath => false,
    }
  }

  ensure_packages($list)
}
