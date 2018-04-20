# ora_profile::database::packages
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::packages
class ora_profile::database::packages(
  Array[String[1]] $list,
) {
  echo {'Packages':}

  package { $list:
    ensure  => present,
  }
}
