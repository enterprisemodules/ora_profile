#
# ora_profile::database::asm_listener
#
# @summary This class contains the definition of the Oracle listener process.
# It installs the specified version of the SQL*net software and start's the listener.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Ora_install::ShortVersion] sqlnet_version
#    The SQLnet version to use.
#    The default is: 19.0
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::asm_listener (
# lint:ignore:strict_indent
  String[1] $dbname,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  Ora_install::ShortVersion
            $sqlnet_version
) inherits ora_profile::database {
# lint:endignore:strict_indent
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { "Ensure Listener for ${dbname} in ${oracle_home}":
    withpath => false,
  }

  ora_install::net { 'config net8':
    oracle_home  => $oracle_home,
    version      => $sqlnet_version,        # Different version then the oracle version
    download_dir => '/tmp',
    user         => $grid_user,
    group        => $install_group,
  }

  -> db_listener { "start_${dbname}":
    ensure          => 'running',
    oracle_home_dir => $oracle_home,
    oracle_base_dir => $oracle_base,
    os_user         => $grid_user,
  }
}
# lint:endignore
