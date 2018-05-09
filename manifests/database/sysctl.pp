# ora_profile::database::sysctl
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::sysctl
class ora_profile::database::sysctl(
  Hash $list,
) inherits ora_profile::database {

  if $list.keys.size > 0 {
    echo {"Ensure DB sysctl param(s) ${list.keys.join(',')}":
      withpath => false,
    }
  }

  $defaults = {
    ensure  => 'present',
    persist => true,
  }
  create_resources(sysctl, $list, $defaults)
}
