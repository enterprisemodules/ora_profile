# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the firewalld firewall
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
class ora_profile::database::firewall::firewalld(
  Array[Integer]  $tcp_ports,
  Array[Integer]  $udp_ports,
  Boolean         $manage_service,
) {
  unless defined(Package['firewalld']) {
    package {'firewalld':
      ensure => 'present',
    }
  }
  $tcp_ports.each |$port| {
    firewalld_port { "500 accept tcp port ${port} for Oracle":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'tcp',
    }
  }

  $udp_ports.each |$port| {
    firewalld_port { "500 accept udp port ${port} for Oracle":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'ucp',
    }
  }
  if $manage_service {
    service { 'firewalld':
        ensure    => true,
        enable    => true,
        hasstatus => true,
    }
  }
}
