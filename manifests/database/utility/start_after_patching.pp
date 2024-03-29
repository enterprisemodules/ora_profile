#
# Sart Oracle entites (e.g. database SIDS, Listeners and OCM's) in homes after they are patched
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
define ora_profile::database::utility::start_after_patching (
  String[1] $os_user,
  Variant[Boolean, Enum['on_failure']]
  $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' })

) {
  $homes_to_be_patched = Array($title,true)
  $db_control_provider = lookup('ora_profile::database::db_control_provider', Optional[String[1]])

  $homes_to_be_patched.each |$patch_home| {
    if ( $patch_home in $facts['ora_install_homes']['running_processes'] ) {
      $running_sids = $facts['ora_install_homes']['running_processes'][$patch_home]['sids'].keys
      $running_listeners = $facts['ora_install_homes']['running_processes'][$patch_home]['listeners']
    } else {
      $running_sids = []
      $running_listeners = []
    }

    if $running_listeners.length > 0 {
      $running_listeners.each |$listener| {
        db_listener { "Start listener ${listener} from home ${patch_home}":
          ensure          => 'start',
          listener_name   => $listener,
          oracle_home_dir => $patch_home,
          os_user         => $os_user,
          schedule        => $schedule,
        }
      }
    }
    if ora_profile::ocm_running_in_homes($homes_to_be_patched) {
      unless $facts['kernel'] == 'Windows' {
        #
        # For now this is hard-coded into one service. So we assume the one exec
        # starts all available connection managers. But.... this might not be the
        # case for all users. Maybe we need to make this more configurable
        # TODO: Add support for starting multiple connection managers
        #
        exec { "Starting OCM after applying DB patches on ${patch_home}" :
          command  => '/bin/systemctl start ocm',
          onlyif   => '/bin/test -e /etc/rc.d/init.d/ocm',
          schedule => $schedule,
        }
      }
    }

    if $running_sids.length > 0 {
      $running_sids.each |$dbname| {
        db_control { "database start ${dbname}":
          ensure                  => 'start',
          # Todo: Add mount option to db_control
          # ensure                  => case $facts['ora_install_homes'][$patch_home]['running_sids'][$dbname]['open_mode'] {
          #   'READ_WRITE', 'READ_ONLY_WITH_APPLY': { 'start' }
          #   'MOUNTED':                            { 'mount' }
          #   default:                              { 'start' }
          # },
          instance_name           => $dbname,
          oracle_product_home_dir => $patch_home,
          os_user                 => $os_user,
          provider                => $db_control_provider,
          schedule                => $schedule,
        }

        if $facts['kernel'] == 'Windows' {
          unless ora_profile::windows_svc_disabled('OracleRemExecServiceV2') {
            exec { 'Start OracleRemExecServiceV2':
              command  => 'Set-Service -Name OracleRemExecServiceV2 -Status Running -PassThru',
              provider => 'powershell',
            }
          }
          unless ora_profile::windows_svc_disabled("OracleJobScheduler${dbname}") {
            exec { "Start OracleJobScheduler${dbname}":
              command  => "Set-Service -Name OracleJobScheduler${dbname} -Status Running -PassThru",
              provider => 'powershell',
            }
          }
          unless ora_profile::windows_svc_disabled("OracleVssWriter${dbname}") {
            exec { "Start OracleVssWriter${dbname}":
              command  => "Set-Service -Name OracleVssWriter${dbname} -Status Running -PassThru",
              provider => 'powershell',
            }
          }
        }
      }
    }
  }
}
