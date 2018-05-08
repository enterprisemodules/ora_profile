# ora_profile::database::firewall::iptables
#
# Open up ports for Oracle using the firewalld firewall
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall::iptables
class ora_profile::database::firewall::firewalld(
  Array[Integer]  $ports,
  Boolean         $manage_service,
) {
  unless defined(Package['firewalld']) {
    package {'firewalld':
      ensure => 'present',
    }
  }
  $ports.each |$port| {
    firewalld_port { "500 accept tcp port ${port} for Oracle":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'tcp',
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
