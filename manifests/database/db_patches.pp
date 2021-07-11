#++--++
#
# ora_profile::database::db_patches
#
# @summary This class contains the definition for the Oracle patches.
# It also contains the definition of the required `Opatch` version.
# 
# The class allows you to specify a patch level and optionally include the OJVM pacthes for the level specified.
# A patch_list to specify additional patches is also supported.
# 
# Keep in mind that when changing the patch level and/or adding patches will cause the listener(s) and database(s) to be stopped and started.
# 
# Applying patches to database software in a RAC environment is only supported on initial run.
# There is no support yet to apply patches on a running system.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
# 
# Also check the set of [common parameters](./common) that is passed to this class.
#
# @param [String[1]] level
#    The patch level the database or grid infrastructure should be patched to.
#    Default value is: `NONE`
#    Valid values depend on your database/grid version, but it should like like below:
#    - `OCT2018RU`
#    - `JAN2019RU`
#    - `APR2019RU`
#    - etc...
#
# @param [Boolean] include_ojvm
#    Specify if the OJVM patch for the patch level should also be installed.
#    Default value is: `false`
#
# @param [String[1]] patch_file
#    The file containing the required Opatch version.
#    The default value is: `p6880880_122010_Linux-x86-64`
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] opversion
#    The version of OPatch that is needed.
#    If it is not installed, Puppet will install the specfied version.
#    If you have defined patches for multiple homes, this version of the OPatch utility will be installed
#    in all of these homes from the patch_file specified. Recent versions of the OPatch utility are exactly
#    the same for Oracle versions 12.1 through 19, so it doesn't matter for which Oracle version you have
#    downloaded it.
#    The default value is: `12.2.0.1.13`
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [Hash] patch_list
#    The list of patches to apply.
#    The default value is : `{}`
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
#--++--
class ora_profile::database::db_patches(
  String[1] $level,
  Boolean   $include_ojvm,
  String[1] $patch_file,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $opversion,
  String[1] $os_user,
  Hash      $patch_list,
  Variant[Boolean,Enum['on_failure']]
            $logoutput = lookup({name => 'logoutput', default_value => 'on_failure'}),
) inherits ora_profile::database::common {
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $include_ojvm ) {
    $ojvm_msg = 'including OJVM'
  } else {
    $ojvm_msg = ''
  }

  if ( $patch_list.keys.size > 0 ) {
    if ( $level == 'NONE' ) {
      echo {"Ensure DB Patch(es) ${patch_list.keys.join(',')} on ${oracle_home}":
        withpath => false,
      }
    } else {
      echo { "Ensure DB patch level ${level} ${ojvm_msg} on ${oracle_home} and patch list ${patch_list.keys.join(',')}":
        withpath => false,
      }
    }
  } else {
    echo { "Ensure DB patch level ${level} ${ojvm_msg} on ${oracle_home}":
      withpath => false,
    }
  }

  $db_version = lookup('ora_profile::database::db_software::version', String)
  $sub_patch_type = 'db'
  if ( $level == 'NONE' ) {
    $patch_level_list = {}
  } elsif ( has_key($patch_levels[$db_version], $level) ) {
    $patch_level_list = $patch_levels[$db_version][$level].map |$patch_name, $patch_details| {
      if ( has_key($patch_details, "${sub_patch_type}_sub_patches") ) {
        $sub_patches = { 'sub_patches' => $patch_details["${sub_patch_type}_sub_patches"] }
      } else {
        fail "patch_levels Hash is missing '${sub_patch_type}_sub_patches' key"
      }
      if ( has_key($patch_details, 'file') ) {
        $patch_source = { 'source' => "${source}/${patch_details['file']}" }
      } else {
        fail "patch_levels Hash is missing 'file' key"
      }
      $current_patch = {
        # Add sub_patches and source
        # Remove db_sub_patches, grid_sub_patches and type
        "${oracle_home}:${patch_name}" => ($patch_details + $sub_patches + $patch_source - 'db_sub_patches' - 'grid_sub_patches' - 'file' - 'type')
      }
      $current_patch
    }.reduce({}) |$memo, $array| { $memo + $array } # Turn Array of Hashes into Hash
  } else {
    fail "Patchlevel '${level}' not defined for database version '${db_version}'"
  }

  if ( $include_ojvm ) {
    $ojvm_patch_levels = lookup('ora_profile::database::db_patches::ojvm_patch_levels', Hash)
    if ( $level == 'NONE' ) {
      $ojvm_patch_list = {}
    } elsif ( has_key($ojvm_patch_levels[$db_version], $level) ) {
      $ojvm_patch_list = $ojvm_patch_levels[$db_version][$level]
    } else {
      fail "OJVM patchlevel '${level}' not defined for database version '${db_version}'"
    }
  } else {
    $ojvm_patch_list = {}
  }
  if ( $is_rac ) {
    if ( $facts['ora_version'] ) {
      echo { 'Patching database software in RAC on a running system is not yet supported':
        withpath => false,
      }
      # Empty complete_patch_list since we cannot patch it anyway
      $complete_patch_list = {}
    } else {
      $complete_patch_list = ($patch_level_list + $ojvm_patch_list + $patch_list)
    }
  } else {
    $complete_patch_list = ($patch_level_list + $ojvm_patch_list + $patch_list)
  }

  #
  # Now start with the patches themselves
  #
  # converted_patch_list contains all the patches in simple notation which is used for echo and to check if any patches need to be installed
  $converted_patch_list = ora_install::ora_physical_patches($complete_patch_list)
  # patch_list_to_apply is the hash with homes and their specified patch details of which at least one need to be applied
  $patch_list_to_apply = ora_install::ora_patches_missing($complete_patch_list, 'db')
  # apply_patches is the hash without the OPatch details which can be given to ora_opatch
  $apply_patches = $patch_list_to_apply.map |$patch, $details| { { $patch => $details } }.reduce({}) |$memo, $array| { $memo + $array }
  $converted_apply_patch_list = ora_install::ora_physical_patches($apply_patches)
  $homes_to_be_patched = $converted_apply_patch_list.map |$patch| { $patch.split(':')[0] }.unique

  schedule {'db_patchschedule':
    range  => $patch_window,
  }

  if ( $::facts['ora_version'] ) {
    echo {"Ensure DB patch(es) in patch window: ${patch_window}":
      withpath => false,
    }
    $schedule = 'db_patchschedule'
  } else {
    $schedule = undef
  }

  # Opatchupgrade in all homes that have patches defined
  $complete_patch_list.map |$patch, $_details| { $patch.split(':')[0] }.unique.each |$home| {
    Ora_install::Opatchupgrade["DB OPatch upgrade to ${opversion} in ${home}"] -> Ora_opatch <| tag == 'db_patches' |>
    ora_install::opatchupgrade{"DB OPatch upgrade to ${opversion} in ${home}":
      oracle_home               => $home,
      patch_file                => "${patch_file}.zip",
      opversion                 => $opversion,
      user                      => $os_user,
      group                     => $install_group,
      puppet_download_mnt_point => $source,
      download_dir              => $download_dir,
    }
  }

  if ( ora_install::ora_patches_installed($converted_patch_list) ) {
    if ( $converted_patch_list.length > 0 ) {
      echo { 'All DB patches already installed. Skipping patches.':
        withpath => false,
      }
    }
  } else {
    if ( $facts['ora_version'] ) {

      unless ( $is_rac ) {
        $ora_install_homes = $facts['ora_install_homes']

        if ( $converted_apply_patch_list.length > 0 ) {
          echo {"Apply DB patch(es) ${converted_apply_patch_list.join(',')}":
            withpath => false,
            schedule => $schedule,
          }
        }

        $homes_to_be_patched.each |$patch_home|  {

          if ( has_key($ora_install_homes, $patch_home) ) {
            $running_sids = $ora_install_homes[$patch_home]['running_sids']
            $running_listeners = $ora_install_homes[$patch_home]['running_listeners']
          } else {
            $running_sids = []
            $running_listeners = []
          }

          if $running_listeners.length > 0 {
            echo {"Stopping and starting listener(s) ${running_listeners.join(',')} to apply DB patches on ${patch_home}":
              withpath => false,
              schedule => $schedule,
            }

            $running_listeners.each |$listener| {
              db_listener {"Stop listener ${listener} from home ${patch_home}":
                ensure          => 'stop',
                listener_name   => $listener,
                oracle_home_dir => $patch_home,
                os_user         => $os_user,
                before          => Ora_opatch[$patch_list_to_apply.keys],
                schedule        => $schedule,
              }
            }
          }
          if $running_sids.length > 0 {
            echo {"Stopping and starting database(s) ${running_sids.join(',')} to apply DB patches on ${patch_home}":
              withpath => false,
              schedule => $schedule,
            }

            $running_sids.each |$dbname| {
              db_control {"database stop ${dbname}":
                ensure                  => 'stop',
                instance_name           => $dbname,
                oracle_product_home_dir => $patch_home,
                os_user                 => $os_user,
                provider                => $db_control_provider,
                before                  => Ora_opatch[$patch_list_to_apply.keys],
                schedule                => $schedule,
              }
            }
          }
        }
      }
    }

    #
    # Some patches need to be installed
    #
    $apply_patches.each |String $patch, Hash $patch_properties = {}| {
      ora_opatch {
        default:
          ensure   => present,
          tmp_dir  => "${download_dir}/patches", # always use subdir, the whole directory will be removed when done
          schedule => $schedule,
          provider => 'regular',
          tag      => 'db_patches',
        ;
        $patch:
          * => $patch_properties,
      }
    }

    if ( $facts['ora_version'] ) {
      #
      # Oracle was running before. We stopped it to do the patching.
      # Now we need to start it again.
      #
      unless ( $is_rac ) {

        $homes_to_be_patched.each |$patch_home|  {

          if ( has_key($ora_install_homes, $patch_home) ) {
            $running_sids = $ora_install_homes[$patch_home]['running_sids']
            $running_listeners = $ora_install_homes[$patch_home]['running_listeners']
          } else {
            $running_sids = []
            $running_listeners = []
          }

          if $running_listeners.length > 0 {
            $running_listeners.each |$listener| {
              db_listener {"Start listener ${listener} from home ${patch_home}":
                ensure          => 'start',
                listener_name   => $listener,
                oracle_home_dir => $patch_home,
                os_user         => $os_user,
                require         => Ora_opatch[$apply_patches.keys],
                schedule        => $schedule,
              }
            }
          }
          if $running_sids.length > 0 {
            $running_sids.each |$dbname| {
              db_control {"database start ${dbname}":
                ensure                  => 'start',
                instance_name           => $dbname,
                oracle_product_home_dir => $patch_home,
                os_user                 => $os_user,
                provider                => $db_control_provider,
                require                 => Ora_opatch[$apply_patches.keys],
                schedule                => $schedule,
              }

              -> exec { "Datapatch for ${dbname}":
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
}
# lint:endignore
