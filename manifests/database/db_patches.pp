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
# @param [Variant[String[1], Hash]] level
#    The patch level the database or grid infrastructure should be patched to.
#    Default value is: `NONE`
#    The value can be a String or a Hash. When the value is a string, the current selected Oracle version (e.g. `ora_profile::database::version`) and the current selected oracle home (e.g. `ora_profile::database::oracle_home`) are used to apply the patch.
#    When you specify a Hash, it must have the following format:
#    ```
#    ora_profile::database::db_patches::level:
#      21cDEFAULT_HOME:
#        version:     21.0.0.0
#        oracle_home: /u01/app/oracle/product/21.0.0.0/db_home1
#        level:       OCT2022RU
#      19cDEFAULT_HOME:
#        version:     19.0.0.0
#        oracle_home: /u01/app/oracle/product/19.0.0.0/db_home1
#        level:       OCT2022RU
#      18cADDITIONAL_HOME:
#        version:     18.0.0.0
#        oracle_home: /u01/app/oracle/product/18.0.0.0/db_home1
#        level:       APR2021RU
#      12cR2ADDITIONAL_HOME:
#        version:     12.2.0.1
#        oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
#        level:       JAN2022RU
#    ```
#    When no level is specified, the level `NONE` is inferred and no level of patches are applied. You can alywas use `patch_list` to specify a specific list of patches to be applied.
#
# @param [Boolean] include_ojvm
#    Specify if the OJVM patch for the patch level should also be installed.
#    Default value is: `false`
#
# @param [Variant[String[1], Hash[Stdlib::Absolutepath, Struct[{patch_file=>String[1], opversion=>Optional[String[1]]}]]]] patch_file
#    The file containing the required Opatch version.
#    The default value is: `p6880880_122010_Linux-x86-64`
#    The value can be a String or a Hash. When the value is a string, the file specified will be used to upgrade OPatch in every ORACLE_HOME on the system.
#    If you want to install different versions in different ORACLE_HOME's you can specify a patch_file per ORACLE_HOME like below.
#    When you specify a Hash, it must have the following format:
#    ```yaml
#    ora_profile::database::db_patches::patch_file:
#      /u01/app/oracle/product/23.0.0.0/db_home1:
#        patch_file: p6880880_230000_Linux-x86-64-12.2.0.1.48
#      /u01/app/oracle/product/21.0.0.0/db_home1:
#        patch_file: p6880880_210000_Linux-x86-64
#        opversion:  12.2.0.1.35
#      /u01/app/oracle/product/19.0.0.0/db_home1
#        patch_file: p6880880_190000_Linux-x86-64
#        opversion:  12.2.0.1.37
#      /u01/app/oracle/product/18.0.0.0/db_home1
#        patch_file: p6880880_180000_Linux-x86-64
#      /u01/app/oracle/product/12.2.0.1/db_home1:
#        patch_file: p6880880_122010_Linux-x86-64-12.2.0.1.21
#        opversion:  12.2.0.1.21
#    ```
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
#    the same for Oracle versions 12.1 through 21, so it doesn't matter for which Oracle version you have
#    downloaded it.
#    The default value is: `12.2.0.1.33`
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
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::db_patches (
# lint:ignore:lookup_in_parameter lint:ignore:manifest_whitespace_opening_brace_before lint:ignore:strict_indent
  Boolean   $include_ojvm,
  Variant[String[1], Hash] $level,
  String[1] $opversion,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $os_user,
  Variant[String[1], Hash[Stdlib::Absolutepath, Struct[{ patch_file => String[1], opversion => Optional[String[1]] }]]]
            $patch_file,
  Hash      $patch_list,
  Variant[Boolean, Enum['on_failure']]
            $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' }),
) inherits ora_profile::database::common {
# lint:endignore
# lint:ignore:variable_scope lint:ignore:manifest_whitespace_opening_brace_before lint:ignore:strict_indent

  easy_type::debug_evaluation() # Show local variable on extended debug

  $db_version = lookup('ora_profile::database::db_software::version', String)

  $messages = ora_profile::level_to_messages($level, $include_ojvm, $patch_list, $oracle_home, $db_version)
  if ($messages.size > 1) {
    echo { $messages:
      withpath => false,
    }
  }

  $db_patch_level_list = ora_profile::level_to_patches( $level, $source, $opversion, $oracle_home, $db_version, 'db' )

  # Oracle 21c doesn't have OJVM patches anymore, they are included in the RU/RUR
  $ojvm_patch_list = if ( $include_ojvm ) and versioncmp($db_version, '21.0.0.0') < 0 {
    ora_profile::level_to_patches( $level, $source, $opversion, $oracle_home, $db_version, 'ojvm' )
  } else {
    {}
  }
  if ( $is_rac ) {
    if ( $facts['ora_version'] ) {
      echo { 'Patching database software in RAC on a running system is not yet supported':
        withpath => false,
      }
      # Empty complete_patch_list since we cannot patch it anyway
      $complete_patch_list = {}
    } else {
      $complete_patch_list = ($db_patch_level_list + $ojvm_patch_list + $patch_list)
    }
  } else {
    $complete_patch_list = ($db_patch_level_list + $ojvm_patch_list + $patch_list)
  }

  #
  # Now start with the patches themselves
  #
  # converted_patch_list contains all the patches in simple notation which is used for echo and to check if any patches need to be installed
  $converted_patch_list = ora_install::ora_physical_patches($complete_patch_list)
  # patch_list_to_apply is the hash with homes and their specified patch details of which at least one need to be applied
  $patch_list_to_apply = ora_install::ora_patches_missing($complete_patch_list, 'db')
  # apply_patches is the hash without the OPatch details which can be given to ora_opatch
  # lint:ignore:manifest_whitespace_closing_brace_before
  # lint:ignore:manifest_whitespace_opening_brace_before
  $apply_patches = $patch_list_to_apply.map |$patch, $details| { { $patch => $details } }.reduce({}) |$memo, $array| { $memo + $array }
  # lint:endignore:manifest_whitespace_closing_brace_before
  # lint:endignore:manifest_whitespace_opening_brace_before
  $converted_apply_patch_list = ora_install::ora_physical_patches($apply_patches).unique
  if $facts['kernel'] == 'Windows' {
    $homes_to_be_patched = $converted_apply_patch_list.map |$patch| { "${patch.split(':')[0]}:${patch.split(':')[1]}" }.unique
  } else {
    $homes_to_be_patched = $converted_apply_patch_list.map |$patch| { $patch.split(':')[0] }.unique
  }
  $running_system = ora_profile::oracle_running() or ora_profile::ocm_running()

  # The flow is as follows:
  # 1) If Oracle/OCM is NOT running.
  #     - Apply all patches directly, regardless of the patch_window. This is the initial rollout case.
  # 2) If Oracle/OCM IS running.
  #   2.1 Patch window is undefined
  #       - Skip patching
  #   2.2) Patch_window is defined.
  #       - Apply the patches within the respective patch window
  #
  #
  if !$running_system {
    # Case 1
    $schedule = undef
    $skip_patching = false
  } else {
    # Case 2
    if $patch_window == undef {
      # Case 2.1
      $skip_patching = true
      $schedule = undef

      echo { 'DB patching disabled because no patch window is defined':
        withpath => false,
      }
    } else {
      # Case 2.2
      $skip_patching = false
      $schedule = 'db_patchschedule'

      echo { "Ensure DB patch(es) in patch window: ${patch_window}":
        withpath => false,
      }

      schedule { 'db_patchschedule':
        range => $patch_window,
      }
    }
  }

  # Opatchupgrade in all homes that are in the catalog
  (easy_type::resources_in_catalog('Ora_install::Installdb') + easy_type::resources_in_catalog('Ora_install::Client')).map |$resource| {
    $home = $resource['oracle_home']
    $opatch_details = ora_profile::get_opatch_details($patch_file, $home, $opversion)
    unless $opatch_details['patch_file'] == 'n/a' {
      $opatch_file = $opatch_details['patch_file']
      $opatch_version = $opatch_details['opversion']
      Ora_install::Opatchupgrade["DB OPatch upgrade to ${opatch_version} in ${home}"] -> Ora_opatch <| tag == 'db_patches' |>
      ora_install::opatchupgrade { "DB OPatch upgrade to ${opatch_version} in ${home}":
        oracle_home               => $home,
        patch_file                => $opatch_file,
        opversion                 => $opatch_version,
        user                      => $os_user,
        group                     => $install_group,
        puppet_download_mnt_point => $source,
        download_dir              => $download_dir,
      }
    }
  }

  if ( ora_install::ora_patches_installed($converted_patch_list) ) {
    if ( $converted_patch_list.length > 0 ) {
      echo { 'All DB patches already installed. Skipping patches.':
        withpath => false,
      }
    }
  } else {
    if (!$skip_patching) {
      if ( $running_system ) {
        unless ( $is_rac ) {
          if ( $converted_apply_patch_list.length > 0 ) {
            echo { "Apply DB patch(es) ${converted_apply_patch_list.join(',')}":
              withpath => false,
              schedule => $schedule,
            }
          }
          ora_profile::database::utility::stop_for_patching { $homes_to_be_patched:
            os_user   => $os_user,
            schedule  => $schedule,
            before    => Ora_opatch[$patch_list_to_apply.keys],
            logoutput => $logoutput,
          }
        }
      }

      #
      # Some patches need to be installed
      #
      $apply_patches.each | String $patch, Hash $patch_properties = {} | {
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

      if ( $running_system ) {
        #
        # Oracle was running before. We stopped it to do the patching.
        # Now we need to start it again.
        #
        unless ( $is_rac ) {
          ora_profile::database::utility::start_after_patching { $homes_to_be_patched:
            os_user   => $os_user,
            schedule  => $schedule,
            logoutput => $logoutput,
            require   => Ora_opatch[$patch_list_to_apply.keys],
          }

          -> ora_profile::database::utility::update_after_patching { $homes_to_be_patched:
            os_user      => $os_user,
            logoutput    => $logoutput,
            schedule     => $schedule,
            download_dir => $download_dir,
          }
        }
      }
    }
  }
}
# lint:endignore
