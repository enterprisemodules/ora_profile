#++--++
#
# ora_profile::database::db_services
#
# @summary This class contains the definition of all the database services you'd like on your system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [Optional[String[1]]] domain_name
#    
#
#--++--
class ora_profile::database::db_services(
  String[1] $dbname,
  Optional[String[1]]
            $domain_name,
) inherits ora_profile::database {
# lint:ignore:variable_scope

  if $domain_name == undef { $service_name = "${dbname}_APP" } else { $service_name = "${dbname}_APP.${domain_name}" }

  echo {"Ensure DB service(s) ${service_name}":
    withpath => false,
  }

  if $ora_profile::database::cluster_nodes {

    $preferred_instances = $ora_profile::database::cluster_nodes.map |$index, $_node| {
      $number = $index + 1
      "${dbname}${number}"
    }

    ora_service {"${service_name}@${db_instance_name}":
      ensure              => 'present',
      preferred_instances => $preferred_instances,
    }

  } else {

    ora_service {"${service_name}@${dbname}":
      ensure => 'present',
    }

  }

}
# lint:endignore
