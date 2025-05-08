#
# ora_profile::database::manage_thp
#
# @summary This class contains the definition of the Transparent HugePages settings required for running Oracle.
# As documented in Oracle support ALERT <https://support.oracle.com/epmos/faces/DocumentDisplay?id=1557478.1>,
# the class will disable Transparent HugePages on RedHat os family starting with version 6.
#
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::manage_thp () {
  echo { 'Ensure management of Transparent HugePages':
    withpath => false,
  }

  easy_type::debug_evaluation() # Show local variable on extended debug

  if $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'], '5') > 0 {
    if versioncmp($facts['os']['release']['major'], '6') == 0 {
      $thp_conf = '/sys/kernel/mm/redhat_transparent_hugepage'
    } else {
      $thp_conf = '/sys/kernel/mm/transparent_hugepage'
    }

    # Starting with UEKR7, the value for transparent_hugepage should be set to 'madvise' instead of 'never'.
    if versioncmp($facts['kernelmajversion'], '5.15') >= 0 {
      $kernel_parameter_value = 'madvise'
    } else {
      $kernel_parameter_value = 'never'
    }

    exec { "set thp runtime to ${kernel_parameter_value}":
      command => "echo ${kernel_parameter_value} > ${thp_conf}/enabled",
      onlyif  => ["test -f ${thp_conf}/enabled", "grep \" ${kernel_parameter_value}\" ${thp_conf}/enabled"],
      path    => '/usr/bin:/bin',
    }

    exec { "set thp defrag runtime to ${kernel_parameter_value}":
      command => "echo ${kernel_parameter_value} > ${thp_conf}/defrag",
      onlyif  => ["test -f ${thp_conf}/defrag", "grep \" ${kernel_parameter_value}\" ${thp_conf}/defrag"],
      path    => '/usr/bin:/bin',
    }

    kernel_parameter { 'transparent_hugepage':
      ensure => present,
      value  => $kernel_parameter_value,
    }
  }
}
