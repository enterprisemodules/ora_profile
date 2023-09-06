#
# This defined type excutes all required update actions after a database has been patched
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [Stdlib::Absolutepath] download_dir
#    The directory where the Puppet software puts all downloaded files.
#    The default value is: `/install`
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
# See the file "LICENSE" for the full license governing this code.
define ora_profile::database::utility::update_after_patching (
  String[1] $os_user,
  Stdlib::Absolutepath $download_dir,
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
          if $facts['kernel'] == 'Windows' {
            file { "${download_dir}\\datapatch_${dbname}.ps1":
              ensure  => file,
              content => epp('ora_profile/command.ps1.epp',
                {
                  'user_password' => $ora_profile::database::common::oracle_user_password,
                  'user'          => $os_user,
                  'command'       => "${patch_home}\\OPatch\\datapatch.bat",
                  'command_args'  => '-verbose',
                  'oracle_home'   => $patch_home,
                  'oracle_sid'    => $dbname,
              }),
            }

            -> exec { "Datapatch for ${dbname}":
              cwd       => "${patch_home}\\OPatch",
              command   => "${download_dir}\\datapatch_${dbname}.ps1",
              provider  => 'powershell',
              logoutput => $logoutput,
              schedule  => $schedule,
              timeout   => 3600,
              require   => [
                Db_control["database start ${dbname}"],
                File["${download_dir}\\datapatch_${$dbname}.ps1"],
              ],
            }

            -> file { "${download_dir}\\utlrp_${dbname}.ps1":
              ensure  => file,
              content => epp('ora_profile/command.ps1.epp',
                {
                  'user_password' => $ora_profile::database::common::oracle_user_password,
                  'user'          => $os_user,
                  'command'       => "${patch_home}\\bin\\sqlplus.exe",
                  'command_args'  => '/ as sysdba @?\\rdbms\\admin\\utlrp',
                  'oracle_home'   => $patch_home,
                  'oracle_sid'    => $dbname,
              }),
            }

            -> exec { "SQLPlus UTLRP ${dbname}":
              cwd       => "${patch_home}/OPatch",
              command   => "${download_dir}\\utlrp_${dbname}.ps1",
              provider  => 'powershell',
              logoutput => $logoutput,
              schedule  => $schedule,
              require   => [
                Db_control["database start ${dbname}"],
                File["${download_dir}\\utlrp_${dbname}.ps1"],
              ],
            }

            -> cleanup { "${download_dir}\\datapatch_${dbname}.ps1": }
            -> cleanup { "${download_dir}\\utlrp_${dbname}.ps1": }
          } else {
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
}
