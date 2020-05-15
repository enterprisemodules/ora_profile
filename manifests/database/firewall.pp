#++--++
#
# ora_profile::database::firewall
#
# @summary This class contains the definition of the firewall settings you need for Oracle.
# When you are using a Redhat flavored version lower then release 7, this module uses the `puppetlabs-firewall` module to manage the `iptables` settings. When using a version 7 or higher, the puppet module `crayfishx-firewalld` to manage the `firewalld daemon`.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
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
class ora_profile::database::firewall(
  Hash    $ports,
  Boolean $manage_service,
) {

  $cluster_nodes = lookup('ora_profile::database::cluster_nodes')
  if $cluster_nodes {
    echo {'Ensure Firewall is disabled for RAC installation':
      withpath => false,
    }
  } else {
    echo {"Ensure Firewall port(s) ${ports.keys.join(',')} are open":
      withpath => false,
    }
  }

  case  $::operatingsystem {
    'RedHat', 'CentOS', 'OracleLinux': {
      case ($::os['release']['major']) {
        '4','5','6': {
          class {'ora_profile::database::firewall::iptables':
            ports          => $ports,
            manage_service => $manage_service,
            cluster_nodes  => $cluster_nodes,
          }
        }
        '7', '8': {
          class {'ora_profile::database::firewall::firewalld':
            ports          => $ports,
            manage_service => $manage_service,
            cluster_nodes  => $cluster_nodes,
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
