# ora_profile::database::db_services
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_services
class ora_profile::database::db_services(
  String[1] $dbname,
  Optional[String[1]]
            $domain_name,
) inherits ora_profile::database {
  echo {'DB services':}

  if $domain_name == undef { $service_name = $dbname} else {$service_name = "${dbname}.${domain_name}" }

  ora_service {"${service_name}@${dbname}":       # Create a service with a name equal to the database
    ensure => 'present',
  }
}
