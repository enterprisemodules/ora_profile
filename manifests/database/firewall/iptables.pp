#
# ora_profile::database::firewall::iptables
#
# @summary Open up ports for Oracle using the iptables
# Here is an example:
# 
# ```puppet
#   include ora_profile::database::firewall::iptables
# ```
#
# @param [Hash] ports
#    A list of TCP ports to open in the firewall.
#    The default value is: `[1521]`
#
# @param [Boolean] manage_service
#    Using this setting you can specify if you want this module to manage the firewall service.
#    The default value is `true` and will make sure the firewall service is started and enabled.
#
# @param [Optional[Array]] cluster_nodes
#    An array with cluster node names for RAC.
#    Example:
#    ```yaml
#    ora_profile::database::cluster_nodes:
#    - node1
#    - node2
#    ```
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::firewall::iptables (
  Optional[Array] $cluster_nodes,
  Boolean         $manage_service,
  Hash            $ports
) {
  easy_type::debug_evaluation() # Show local variable on extended debug

  # Oracle recommends to disable firewalld for RAC installations
  if $cluster_nodes {
    service { 'iptables':
      ensure => stopped,
      enable => false,
    }
  } else {
    unless defined(Package['iptables']) {
      package { 'iptables':
        ensure => 'present',
      }
    }

    $fw_ports = $ports.map | $name, $props | { Hash( $name => $props.each |$_k, $v| { Hash ('dport' => $v ) }[0]) }[0]

    $defaults = {
      ensure => 'present',
      jump   => 'accept',
      proto  => 'tcp',
    }
    ensure_resources('firewall', $fw_ports, $defaults)

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
