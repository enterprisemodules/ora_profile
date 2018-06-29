#++--++
#
#--++--
define ora_profile::database::authenticated_nodes::user_equivalence(
  String            $private_key,
  Array[String[1]]  $nodes        = ['localhost'],
)
{
  #
  # Validate input
  #
  assert_type(String[1], $name)           |$e, $a| { fail "name is ${a}, expect a non empty string"}

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

  $nodes.each |$node|{
    exec{"authorize_node_${node}_for_${name}":
      user    => $name,
      command => "/usr/bin/scp -o StrictHostKeyChecking=no x ${name}@${node}:~",
      unless  => "/bin/grep '^${node}[, ]' /home/${name}/.ssh/known_hosts",
      returns => [0,1],
      require => File["/home/${name}/.ssh/id_rsa"],
    }
  }
}
