# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the iptables
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
class ora_profile::database::firewall::iptables(
  Array[Integer]  $tcp_ports,
  Array[Integer]  $udp_ports,
  Boolean         $manage_service,
) {
  $tcp_ports.each |$port| {
    firewall { "500 accept tcp port ${port} for Oracle":
      proto  => 'tcp',
      action => 'accept',
    }
  }

  $udp_ports.each |$port| {
    firewall { "500 accept udp port ${port} for Oracle":
      proto  => 'udp',
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
