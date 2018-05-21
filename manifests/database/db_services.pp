#++--++
#
# ora_profile::db_services
#
# @summary This class contains the definition of all the database services you'd like on your system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistenly use the hiera key `ora_profile::database::dbname`.
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

  if $domain_name == undef { $service_name = $dbname} else {$service_name = "${dbname}.${domain_name}" }

  echo {"Ensuring DB service ${service_name}":
    withpath => false,
  }


  ora_service {"${service_name}@${dbname}":       # Create a service with a name equal to the database
    ensure => 'present',
  }
}
