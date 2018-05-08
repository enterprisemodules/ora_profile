# ora_profile::database::firewall
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall
class ora_profile::database::firewall(
  Array[Integer]  $ports,
  Boolean         $manage_service,
) inherits ora_profile::database {

  echo {"Firewall: ensuring tcp port(s) ${ports.join(',')} are open.":
    withpath => false,
  }

  case  $::operatingsystem {
    'RedHat', 'CentOS', 'OracleLinux': {
      case ($::os['release']['major']) {
        '4','5','6': {
          class {'ora_profile::database::firewall::iptables':
            ports          => $ports,
            manage_service => $manage_service,
          }
        }
        '7': {
          class {'ora_profile::database::firewall::firewalld':
            ports          => $ports,
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
