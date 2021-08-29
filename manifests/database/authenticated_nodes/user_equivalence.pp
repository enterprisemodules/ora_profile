#
# ora_profile::database::authenticated_nodes::user_equivalence
#
# @summary Setup user equivalence for the specified user on specified nodes.
#
#
# @param [String] private_key
#    The private key of the user.
#
# @param [Array[String[1]]] nodes
#    The cluster nodes.
#
#
# See the file "LICENSE" for the full license governing this code.
#
define ora_profile::database::authenticated_nodes::user_equivalence(
  String            $private_key,
  Array[String[1]]  $nodes        = ['localhost'],
)
{
  easy_type::debug_evaluation() # Show local variable on extended debug

  #
  # Validate input
  #
  assert_type(String[1], $name)           |$e, $a| { fail "name is ${a}, expect a non empty string"}

  unless defined(Package['openssh-clients']) {
    package { 'openssh-clients':
      ensure => 'present',
    }
  }

  file{"/home/${name}/.ssh":
    ensure  => 'directory',
    mode    => '0700',
    owner   => $name,
    require => User[$name],
  }

  file{"/home/${name}/.ssh/id_rsa":
    ensure  => 'file',
    content => $private_key,
    mode    => '0700',
    owner   => $name,
    require => File["/home/${name}/.ssh"],
  }

  $nodes.each |$node_name|{
    exec{"authorize_node_${node_name}_for_${name}":
      user    => $name,
      command => "/usr/bin/ssh-keyscan ${node_name} >> ~/.ssh/known_hosts",
      unless  => "/bin/grep ${node_name} /home/${name}/.ssh/known_hosts",
      returns => [0,1],
      require => [
        File["/home/${name}/.ssh/id_rsa"],
        Package['openssh-clients'],
      ]
    }
  }
}
