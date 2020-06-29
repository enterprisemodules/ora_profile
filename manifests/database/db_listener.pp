#++--++
#
# ora_profile::database::db_listener
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
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] dba_group
#    The group to use for Oracle DBA users.
#    The default is : `dba`
#    To customize this consistently use the hiera key `ora_profile::database::dba_group`.
#
# @param [Ora_install::ShortVersion] sqlnet_version
#    The SQLnet version to use.
#    The default is: 12.2
#
# @param [Variant[String[1], Hash]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#    This parameter can also be defined as Hash in case you need multiple listeners.
#    The keys of the hash are the database names, and for every key you can specify all valid parameters for the class.
#    The defaults for all key(s) in the Hash are the ones given to the class.
#
#--++--
class ora_profile::database::db_listener(
  Stdlib::Absolutepath
            $oracle_home,
  Stdlib::Absolutepath
            $oracle_base,
  String[1] $os_user,
  String[1] $dba_group,
  Ora_install::ShortVersion
            $sqlnet_version,
  Variant[String[1], Hash]
            $dbname,
) inherits ora_profile::database {
# lint:ignore:variable_scope

  $listener_defaults = {
    oracle_home    => $oracle_home,
    oracle_base    => $oracle_base,
    os_user        => $os_user,
    install_group  => $install_group,
    sqlnet_version => $sqlnet_version,
    db_port        => 1521,
  }

  if ( $dbname =~ String ) {
    echo {"Ensure Listener for ${dbname} in ${oracle_home}":
      withpath => false,
    }
    $listener = { 'LISTENER' => $listener_defaults }
  } else {
    $dbname.each |$db, $db_props| {
      echo {"Ensure Listener for ${db} in ${db_props['oracle_home']}":
        withpath => false,
      }
    }
    $listener = $dbname.map |$db, $db_props| { { $db => deep_merge($listener_defaults, $db_props) } }.reduce({}) |$memo, $array| { $memo + $array }
  }

  $listener.each |$lsnr, $lsnr_props| {

    ora_install::net{ "config net8 for ${lsnr_props['oracle_home']}":
      oracle_home   => $lsnr_props['oracle_home'],
      version       => $lsnr_props['sqlnet_version'], # Different version then the oracle version
      user          => $lsnr_props['os_user'],
      group         => $lsnr_props['install_group'],
      download_dir  => $download_dir,
      temp_dir      => $temp_dir,
      db_port       => $lsnr_props['db_port'],
      listener_name => $lsnr,
    }

    -> ora_install::listener{"start listener ${lsnr} from ${lsnr_props['oracle_home']}":
      oracle_base   => $lsnr_props['oracle_base'],
      oracle_home   => $lsnr_props['oracle_home'],
      user          => $lsnr_props['os_user'],
      group         => $lsnr_props['install_group'],
      listener_name => $lsnr,
      action        => 'start',
    }

  }
}
# lint:endignore:variable_scope
