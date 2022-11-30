#
# ora_profile::database::db_startup
#
# @summary This class contains the definition for the auto startup of Oracle after a system reboot.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
# 
# Also check the set of [common parameters](./common) that is passed to this class.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [Enum['database', 'grid']] db_type
#    The type of the database used to specify if the database should be started by an init script or srvctl.
#    Valid values are:
#    - `grid`
#    - `database`
#    The default value is: 'database'
#
# @param [Optional[Hash]] limits
#    The limits for the systemd service.
#    The default value is:
#    ```yaml
#    ora_profile::database::db_startup::limits:
#      '*/nofile':
#        soft: 2048
#        hard: 8192
#      'oracle/nofile':
#        soft: 65536
#        hard: 65536
#      'oracle/nproc':
#        soft: 2048
#        hard: 16384
#      'oracle/stack':
#        soft: 10240
#        hard: 32768
#    ```
#
# @param [Optional[String[1]]] systemd_template
#    Use custom EPP template for systemd service
#    The default value is: undef
#
# @param [Optional[Hash]] systemd_template_vars
#    The variables to use when specifying a custom EPP template for systemd service
#    The default value is: undef
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::db_startup (
# lint:ignore:strict_indent
  Enum['database', 'grid']
            $db_type,
  String[1] $dbname,
  Optional[Hash]
            $limits,
  Stdlib::Absolutepath
            $oracle_home,
  Optional[String[1]]
            $systemd_template,
  Optional[Hash]
            $systemd_template_vars,
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { "Ensure DB Startup for ${dbname} in ${oracle_home}":
    withpath => false,
  }

  # In RHEL7.2 RemoveIPC defaults to true, which will cause the database and ASM to crash
  if $facts['os']['release']['major'] == '7' and $facts['os']['release']['minor'] == '2' {
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

  ora_install::autostartdatabase { "autostart ${dbname}":
    oracle_home           => $oracle_home,
    db_name               => $dbname,
    db_type               => $db_type,
    limits                => $limits,
    systemd_template      => $systemd_template,
    systemd_template_vars => $systemd_template_vars,
  }
}
