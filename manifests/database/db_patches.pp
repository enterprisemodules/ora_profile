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
# lint:ignore:strict_indent
# lint:ignore:lookup_in_parameter
  Boolean   $include_ojvm,
  Variant[String[1], Hash] $level,
  String[1] $opversion,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $os_user,
  String[1] $patch_file,
  Hash      $patch_list,
  Variant[Boolean, Enum['on_failure']]
            $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' })
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
# lint:endignore:lookup_in_parameter
# lint:ignore:variable_scope

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
  $homes_to_be_patched = $converted_apply_patch_list.map |$patch| { $patch.split(':')[0] }.unique
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
        range  => $patch_window,
      }
    }
  }

  # Opatchupgrade in all homes that are in the catalog
  (easy_type::resources_in_catalog('Ora_install::Installdb') + easy_type::resources_in_catalog('Ora_install::Client')).map |$resource| {
    $home = $resource['oracle_home']
    Ora_install::Opatchupgrade["DB OPatch upgrade to ${opversion} in ${home}"] -> Ora_opatch <| tag == 'db_patches' |>
    ora_install::opatchupgrade { "DB OPatch upgrade to ${opversion} in ${home}":
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
            os_user   => $os_user,
            logoutput => $logoutput,
            schedule  => $schedule,
          }
        }
      }
    }
  }
}
# lint:endignore
