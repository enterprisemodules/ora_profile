# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the iptables
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
class ora_profile::database::firewall::iptables(
  Array[Integer]  $ports,
  Boolean         $manage_service,
) {
  unless defined(Package['iptables']) {
    package {'iptables':
      ensure => 'present',
    }
  }

  $ports.each |$port| {
    firewall { "500 accept tcp port ${port} for Oracle":
      proto  => 'tcp',
      action => 'accept',
    }
  }

  if $manage_service {
    service { 'iptables':
        ensure    => true,
        enable    => true,
        hasstatus => true,
    }
  }
}