# ora_profile::database::firewall
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall
class ora_profile::database::firewall(
  Array[Integer]  $tcp_ports,
  Array[Integer]  $udp_ports,
  Boolean         $manage_service,
) {
  echo {"Firewall: opening tcp ports ${tcp_ports.join(',')} and udp_ports ${udp_ports.join(',')}":}

  case  $::operatingsystem {
    'RedHat', 'CentOS', 'OracleLinux': {
      case ($::os['release']['major']) {
        '4','5','6': {
          class {'ora_profile::database::firewall::iptables':
            tcp_ports      => $tcp_ports,
            udp_ports      => $udp_ports,
            manage_service => $manage_service,
          }
        }
        '7': {
          class {'ora_profile::database::firewall::firewalld':
            tcp_ports      => $tcp_ports,
            udp_ports      => $udp_ports,
            manage_service => $manage_service,
          }
        }
        default: { fail 'unsupported OS version when checking firewall service'}
      }
    }
    'Solaris':{
      warning 'No firewall rules added on Solaris.'
    }
    default: {
        fail "${::operatingsystem} is not supported."
    }
  }
}
