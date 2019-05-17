#++--++
#
# ora_profile::packages
#
# @summary This class contains the definition all the packages you need to have installed on your system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] list
#    The required packages for a succesfull Oracle installation.
#    The defaults are:
#    ```yaml
#    ora_profile::database::packages::list:
#    - binutils.x86_64
#    - compat-libcap1.x86_64
#    - compat-libstdc++-33.i686
#    - compat-libstdc++-33.x86_64
#    - gcc.x86_64
#    - gcc-c++.x86_64
#    - glibc.i686
#    - glibc.x86_64
#    - glibc-devel.i686
#    - glibc-devel.x86_64
#    - ksh
#    - libaio.i686
#    - libaio.x86_64
#    - libaio-devel.i686
#    - libaio-devel.x86_64
#    - libgcc.i686
#    - libgcc.x86_64
#    - libstdc++.i686
#    - libstdc++.x86_64
#    - libstdc++-devel.i686
#    - libstdc++-devel.x86_64
#    - libXi.i686
#    - libXi.x86_64
#    - libXtst.i686
#    - libXtst.x86_64
#    - make.x86_64
#    - sysstat.x86_64
#    ```
#
#--++--
class ora_profile::database::asm_packages(
  Hash $list,
) inherits ora_profile::database {

  if $list.size > 0 {
    $packages = $list.keys
    echo {"Ensure ASM Packages(s) ${packages.join(',')}":
      withpath => false,
    }
  }

  ensure_packages($list)
}
