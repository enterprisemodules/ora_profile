# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the firewalld firewall
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
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
    contain ::firewalld

    $defaults = {
      ensure   => 'present',
      zone     => 'public',
      protocol => 'tcp'
    }
    create_resources('firewalld_port', $ports, $defaults)

    # Add logging chain to log all dropped connections
    firewalld_direct_chain {'Add custom chain Logging-chain':
      ensure        => present,
      name          => 'Logging-chain',
      inet_protocol => 'ipv4',
      table         => 'filter',
    }

    firewalld_direct_rule {'Add rule to Logging-chain':
      ensure        => present,
      inet_protocol => 'ipv4',
      table         => 'filter',
      chain         => 'Logging-chain',
      priority      => 0,
      args          => '-j LOG --log-prefix " ## FIREWALLD DROPPED ## "',
    }

    firewalld_direct_passthrough {'Add passthrough for Logging-chain':
      ensure        => present,
      inet_protocol => 'ipv4',
      args          => '-A IN_public -j Logging-chain',
    }
  }

}
