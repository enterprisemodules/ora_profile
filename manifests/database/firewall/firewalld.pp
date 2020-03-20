# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the firewalld firewall
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
# lint:ignore:variable_scope
class ora_profile::database::firewall::firewalld(
  Hash    $ports,
  Boolean $manage_service,
) inherits ora_profile::database {

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
