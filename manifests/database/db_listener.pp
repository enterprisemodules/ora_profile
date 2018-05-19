# ora_profile::database::db_listener
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_listener
class ora_profile::database::db_listener(
  Stdlib::Absolutepath
            $oracle_home,
  Stdlib::Absolutepath
            $oracle_base,
  String[1] $sqlnet_version,
  String[1] $dbname,
) inherits ora_profile::database {

  echo {"DB listener for ${dbname} in ${oracle_home}":
    withpath => false,
  }

  ora_install::net{ 'config net8':
    oracle_home  => $oracle_home,
    version      => $sqlnet_version,        # Different version then the oracle version
    download_dir => '/tmp',
  }

  -> ora_install::listener{"start_${dbname}":
    oracle_base => $oracle_base,
    oracle_home => $oracle_home,
    action      => 'start',
  }

}
