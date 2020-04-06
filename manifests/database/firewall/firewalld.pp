#++--++
#
# ora_profile::database::firewall::firewalld
#
# @summary Open up ports for Oracle using the firewalld firewall
# Here is an example:
# 
# ```puppet
#   include ora_profile::database::firewall::firewalld
# ```
#
# @param [Hash] ports
#    A list of TCP ports to open in the firewall.
#    The default value is: `[1521]`
#
# @param [Boolean] manage_service
#    Using this setting you can specify if you want this module to manage the firewall service.
#    The default value is `true` and will make sure the firewall service is started and enabled.
#
#--++--
class ora_profile::database::firewall::firewalld(
  Hash    $ports,
  Boolean $manage_service,
) inherits ora_profile::database {
# lint:ignore:variable_scope

  # Oracle recommends to disable firewalld for RAC installations
  if $cluster_nodes {
    service { 'firewalld':
      ensure => stopped,
      enable => false,
    }
  } else {

    class { 'firewalld':
      log_denied => 'all',
    }

    contain ::firewalld

    $defaults = {
      ensure   => 'present',
      zone     => 'public',
      protocol => 'tcp'
    }
    ensure_resources('firewalld_port', $ports, $defaults)

  }
}
# lint:endignore
