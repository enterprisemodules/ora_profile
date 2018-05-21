#++--++
#
# ora_profile::db_listener
#
# @summary This class contains the definition of the Oracle listener process.
# It installs the specified version of the SQL*net software and start's the listener.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistenly use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistenly use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] sqlnet_version
#    The SQLnet version to use.
#    The default is: 12.2
#
#--++--
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
