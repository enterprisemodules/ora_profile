# ora_profile::database::startup
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_startup
class ora_profile::database::db_startup(
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $dbname,
) {
  echo {'DB Startup':}

  # In RHEL7.2 RemoveIPC defaults to true, which will cause the database and ASM to crash
  if $::os['release']['major'] == '7' and $::os['release']['minor'] == '2' {
    file_line { 'Do not remove ipc':
      path   => '/etc/systemd/logind.conf',
      line   => 'RemoveIPC=no',
      match  => "^#RemoveIPC.*$",
      notify => Exec['systemctl daemon-reload'],
    }
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
