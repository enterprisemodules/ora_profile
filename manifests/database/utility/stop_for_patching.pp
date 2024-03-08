#
# Stop Oracle entites (e.g. database SIDS, Listeners and OCM's) in homes to be patches
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
define ora_profile::database::utility::stop_for_patching (
  String[1] $os_user,
  Variant[Boolean, Enum['on_failure']]
  $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' })
) {
  $homes_to_be_patched = Array($title, true)
  $db_control_provider  = lookup('ora_profile::database::db_control_provider', Optional[String[1]])

  $homes_to_be_patched.each |$patch_home| {
    if ( $patch_home in $facts['ora_install_homes']['running_processes'] ) {
      $running_sids = $facts['ora_install_homes']['running_processes'][$patch_home]['sids'].keys
      $running_listeners = $facts['ora_install_homes']['running_processes'][$patch_home]['listeners']
    } else {
      $running_sids = []
      $running_listeners = []
    }

    if $running_listeners.length > 0 {
      echo { "Stopping and starting listener(s) ${running_listeners.join(',')} to apply DB patches on ${patch_home}":
        withpath => false,
        schedule => $schedule,
      }

      $running_listeners.each |$listener| {
        db_listener { "Stop listener ${listener} from home ${patch_home}":
          ensure          => 'stop',
          listener_name   => $listener,
          oracle_home_dir => $patch_home,
          os_user         => $os_user,
          schedule        => $schedule,
        }
      }
    }
    if ora_profile::ocm_running_in_homes($homes_to_be_patched) {
      unless $facts['kernel'] == 'Windows' {
        echo { "Stopping and starting OCM to apply DB patches on ${patch_home}":
          withpath => false,
          schedule => $schedule,
        }
        #
        # For now this is hard-coded into one service. So we assume the one exec
        # stops all available connection managers. But.... this might not be the
        # case for all users. Maybe we need to make this more configurable
        # TODO: Add support for stopping multiple connection managers
        #
        exec { "stop OCM for patching on ${patch_home}" :
          command  => '/bin/systemctl stop ocm',
          onlyif   => '/bin/test -e /etc/rc.d/init.d/ocm',
          schedule => $schedule,
        }
      }
    }
    if $running_sids.length > 0 {
      echo { "Stopping and starting database(s) ${running_sids.join(',')} to apply DB patches on ${patch_home}":
        withpath => false,
        schedule => $schedule,
      }

      $running_sids.each |$dbname| {
        if $facts['kernel'] == 'Windows' {
          if ora_profile::windows_svc_running('OracleRemExecServiceV2') {
            exec { 'Stop OracleRemExecServiceV2':
              command  => 'Set-Service -Name OracleRemExecServiceV2 -Status Stopped -PassThru',
              provider => 'powershell',
            }
          }
          if ora_profile::windows_svc_running("OracleJobScheduler${dbname}") {
            exec { "Stop OracleJobScheduler${dbname}":
              command  => "Set-Service -Name OracleJobScheduler${dbname} -Status Stopped -PassThru",
              provider => 'powershell',
            }
          }
          if ora_profile::windows_svc_running("OracleVssWriter${dbname}") {
            exec { "Stop OracleVssWriter${dbname}":
              command  => "Set-Service -Name OracleVssWriter${dbname} -Status Stopped -PassThru",
              provider => 'powershell',
            }
          }
        }

        db_control { "database stop ${dbname}":
          ensure                  => 'stop',
          instance_name           => $dbname,
          oracle_product_home_dir => $patch_home,
          os_user                 => $os_user,
          provider                => $db_control_provider,
          schedule                => $schedule,
        }
      }
    }
  }
}
