#
# This defined type excutes all required update actions after a database has been patched
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
# 
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
#
# See the file "LICENSE" for the full license governing this code.
define ora_profile::database::utility::update_after_patching (
  String[1] $os_user,
  Variant[Boolean, Enum['on_failure']]
  $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' })
) {
  $homes_to_be_patched = Array($title, true)

  $homes_to_be_patched.each |$patch_home| {
    if ( $patch_home in $facts['ora_install_homes']['running_processes'] ) {
      $running_sids = $facts['ora_install_homes']['running_processes'][$patch_home]['sids'].keys
    } else {
      $running_sids = []
    }

    if $running_sids.length > 0 {
      $running_sids.each |$dbname| {
        if ( $facts['ora_install_homes']['running_processes'][$patch_home]['sids'][$dbname]['open_mode'] == 'READ_WRITE' ) {
          exec { "Datapatch for ${dbname}":
            cwd         => "${patch_home}/OPatch",
            command     => "/bin/sh -c 'unset ORACLE_PATH SQLPATH TWO_TASK TNS_ADMIN; ${patch_home}/OPatch/datapatch -verbose'",
            environment => [
              "PATH=/usr/bin:/bin:${patch_home}/bin",
              "ORACLE_SID=${dbname}",
              "ORACLE_HOME=${patch_home}",
            ],
            user        => $os_user,
            logoutput   => $logoutput,
            timeout     => 3600,
            schedule    => $schedule,
          }

          -> exec { "SQLPlus UTLRP ${dbname}":
            cwd         => $patch_home,
            command     => "/bin/sh -c 'unset TWO_TASK TNS_ADMIN; ${patch_home}/bin/sqlplus / as sysdba @?/rdbms/admin/utlrp'",
            environment => [
              "PATH=/usr/bin:/bin:${patch_home}/bin",
              "ORACLE_SID=${dbname}",
              "ORACLE_HOME=${patch_home}",
            ],
            user        => $os_user,
            logoutput   => $logoutput,
            timeout     => 3600,
            schedule    => $schedule,
          }
        }
      }
    }
  }
}
