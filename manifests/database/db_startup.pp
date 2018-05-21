#++--++
#
# ora_profile::db_startup
#
# @summary This class contains the definition for the auto startup of Oracle after a system reboot.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistenly use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistenly use the hiera key `ora_profile::database::dbname`.
#
#--++--
class ora_profile::database::db_startup(
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $dbname,
) inherits ora_profile::database {

  echo {"Ensure DB Startup for ${dbname} in ${oracle_home}":
    withpath => false,
  }

  # In RHEL7.2 RemoveIPC defaults to true, which will cause the database and ASM to crash
  if $::os['release']['major'] == '7' and $::os['release']['minor'] == '2' {
    # lint:ignore:double_quoted_strings
    file_line { 'Do not remove ipc':
      path   => '/etc/systemd/logind.conf',
      line   => 'RemoveIPC=no',
      match  => "^#RemoveIPC.*$",
      notify => Exec['systemctl daemon-reload'],
    }
    # lint:endignore:double_quoted_strings
    ->exec { 'systemctl daemon-reload':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
      require     => File_line['Do not remove ipc'],
      notify      => Service['systemd-logind'],
    }
    ->service { 'systemd-logind':
      provider   => 'systemd',
      hasrestart => true,
      subscribe  => Exec['systemctl daemon-reload'],
    }
  }

  ora_install::autostartdatabase{ "autostart ${dbname}":
    oracle_home => $oracle_home,
    db_name     => $dbname,
  }

}
