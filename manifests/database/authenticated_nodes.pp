#++--++
#
#--++--
# lint:ignore:variable_scope
class ora_profile::database::authenticated_nodes (
  String[1] $oracle_private_key,
  String[1] $grid_private_key,
  Hash      $keys = {},
) inherits ora_profile::database {

  echo {"Ensure User equivalence for users ${os_user} and ${grid_user}":
    withpath => false,
  }

  create_resources('ssh_authorized_key', $keys)

  ora_profile::database::authenticated_nodes::user_equivalence{$os_user:
    nodes       => $ora_profile::database::cluster_nodes,
    private_key => $oracle_private_key,
  }

  ora_profile::database::authenticated_nodes::user_equivalence{$grid_user:
    nodes       => $cluster_nodes,
    private_key => $grid_private_key,
  }
}
# lint:endignore
