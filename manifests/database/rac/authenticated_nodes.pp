#
# ora_profile::database::rac::authenticated_nodes
#
# @summary Setup authentication for the cluster nodes.
# Only applicable for RAC.
#
# @param [String[1]] oracle_private_key
#    The private key of the oracle user.
#
# @param [String[1]] grid_private_key
#    The private key of the grid user.
#
# @param [Hash] keys
#    Hash with users and the public keys they will get.
#    Here is an example:
#    ```yaml
#    ora_profile::database::rac::authenticated_nodes::keys:
#      oracle_for_grid:
#        ensure: present
#        user: grid
#        type: rsa
#        key: '<public key>'
#      grid_for_oracle:
#        ensure: present
#        user: oracle
#        type: rsa
#        key: '<public key>'
#    ```
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::rac::authenticated_nodes (
  String[1] $grid_private_key,
  String[1] $oracle_private_key,
  Hash      $keys = {}
) inherits ora_profile::database {
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $os_user == $grid_user ) {
    echo { "Ensure User equivalence for user ${os_user}":
      withpath => false,
    }
  } else {
    echo { "Ensure User equivalence for users ${os_user} and ${grid_user}":
      withpath => false,
    }
  }

  ensure_resources('ssh_authorized_key', $keys)

  if ( $os_user == $grid_user ) {
    ora_profile::database::authenticated_nodes::user_equivalence { $os_user:
      nodes       => $ora_profile::database::cluster_nodes,
      private_key => $oracle_private_key,
    }
  } else {
    ora_profile::database::authenticated_nodes::user_equivalence { $os_user:
      nodes       => $ora_profile::database::cluster_nodes,
      private_key => $oracle_private_key,
    }

    ora_profile::database::authenticated_nodes::user_equivalence { $grid_user:
      nodes       => $cluster_nodes,
      private_key => $grid_private_key,
    }
  }
}
# lint:endignore
