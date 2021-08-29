#
# ora_profile::database::disable_thp
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
class ora_profile::database::disable_thp() {

  echo {'Ensure Transparent HugePages are disabled':
    withpath => false,
  }

  easy_type::debug_evaluation() # Show local variable on extended debug

  if $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'], '5') > 0 {

    if versioncmp($facts['os']['release']['major'], '6') == 0 {
      $thp_conf = '/sys/kernel/mm/redhat_transparent_hugepage'
    } else {
      $thp_conf = '/sys/kernel/mm/transparent_hugepage'
    }

    exec { 'disable thp runtime':
      command => "echo never > ${thp_conf}/enabled",
      onlyif  => ["test -f ${thp_conf}/enabled", "grep \" never\" ${thp_conf}/enabled"],
      path    => '/usr/bin:/bin',
    }

    exec { 'disable thp defrag runtime':
      command => "echo never > ${thp_conf}/defrag",
      onlyif  => ["test -f ${thp_conf}/defrag", "grep \" never\" ${thp_conf}/defrag"],
      path    => '/usr/bin:/bin',
    }

    kernel_parameter { 'transparent_hugepage':
      ensure => present,
      value  => 'never',
    }
  }
}
