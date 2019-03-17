# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the iptables
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
class ora_profile::database::firewall::iptables(
  Hash    $ports,
  Boolean $manage_service,
) {

  # Oracle recommends to disable firewalld for RAC installations
  if $ora_profile::database::cluster_nodes {
    service { 'iptables':
      ensure => stopped,
      enable => false,
    }
  } else {
    unless defined(Package['iptables']) {
      package {'iptables':
        ensure => 'present',
      }
    }

    $defaults = {
      ensure => 'present',
      action => 'accept',
      proto  => 'tcp'
    }
    ensure_resources('firewall', $ports, $defaults)

    firewall { '900 log dropped input chain':
      chain      => 'INPUT',
      jump       => 'LOG',
      log_level  => '6',
      log_prefix => ' ## IPTABLES DROPPED ## ',
      proto      => 'all',
      before     => undef,
    }

    if $manage_service {
      service { 'iptables':
          ensure    => true,
          enable    => true,
          hasstatus => true,
      }
    }
  }
}
