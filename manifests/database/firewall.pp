# ora_profile::database::firewall
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::firewall
class ora_profile::database::firewall {
  echo {'Firewall':}

  case ($::os['release']['major']) {
    '4','5','6': { $firewall_service = 'iptables'}
    '7': { $firewall_service = 'firewalld' }
    default: { fail 'unsupported OS version when checking firewall service'}
  }

  service { $firewall_service:
      ensure    => false,
      enable    => false,
      hasstatus => true,
  }

}
