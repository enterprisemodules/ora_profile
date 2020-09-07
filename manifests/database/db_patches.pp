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
# @param [String[1]] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param [Hash] patch_list
#    The list of patches to apply.
#    The default value is : `{}`
#
# @param [String[1]] level
#    The patch level the database should be patched to.
#    Default value is: `NONE`
#    Valid values depend on your database version, but it should like like below:
#    - `OCT2018RU`
#    - `JAN2019RU`
#    - `APR2019RU`
#    - etc...
#
# @param [String[1]] patch_window
#    The patch window in which you want to do the patching.
#    Every time puppet runs outside of this patcn windows, puppet will detect the patches are not installed, but puppet will not shutdown the database and apply the patches.
#    an example on how to use this is:
#            patch_window => '2:00 - 4:00'
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
# @param [Boolean] include_ojvm
#    Specify if the OJVM patch for the patch level should also be installed.
#    Default value is: `false`
#
#--++--
class ora_profile::database::db_patches(
  String[1] $level,
  Boolean   $include_ojvm,
  String[1] $patch_file,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $opversion,
  String[1] $install_group,
  String[1] $os_user,
  String[1] $source,
  Hash      $patch_list,
  String[1] $patch_window,
  Variant[Boolean,Enum['on_failure']]
            $logoutput = lookup({name => 'logoutput', default_value => 'on_failure'}),
) inherits ora_profile::database {
# lint:ignore:variable_scope

  # Always execute Ora_install::Opatchupgrade before any Ora_opatch
  Ora_install::Opatchupgrade <| |> -> Ora_opatch <| |>

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

  $patch_levels = lookup('ora_profile::database::db_patches::patch_levels', Hash)
  $db_version = lookup('ora_profile::database::db_software::version', String)
  if ( has_key($patch_levels[$db_version], $level) ) {
    $patch_level_list = $patch_levels[$db_version][$level]
  } else {
    $patch_level_list = {}
  }
  if ( $include_ojvm ) {
    $ojvm_patch_levels = lookup('ora_profile::database::db_patches::ojvm_patch_levels', Hash)
    if ( has_key($ojvm_patch_levels[$db_version], $level) ) {
      $ojvm_patch_list = $ojvm_patch_levels[$db_version][$level]
    } else {
      $ojvm_patch_list = {}
    }
  } else {
    $ojvm_patch_list = {}
  }
  $complete_patch_list = ($patch_level_list + $ojvm_patch_list + $patch_list)

  #
  # Now start with the patches themselves
  #
  # converted_patch_list contains all the patches in simple notation which is used for echo and to check if any patches need to be installed
  $converted_patch_list = ora_physical_patches($complete_patch_list)
  # patch_list_to_apply is the hash with patches that need to be applied, without patches that have already been applied
  $patch_list_to_apply = ora_install::ora_patches_missing($complete_patch_list)
  # apply_patches is the hash without the OPatch details which can be given to ora_opatch
  $apply_patches = $patch_list_to_apply.map |$patch, $details| { { $patch => $details } }.reduce({}) |$memo, $array| { $memo + $array }
  $converted_apply_patch_list = ora_physical_patches($apply_patches)
  $homes_to_be_patched = $converted_apply_patch_list.map |$patch| { $patch.split(':')[0] }.unique

  schedule {'patchschedule':
    range  => $patch_window,
  }

  if ( $::facts['ora_version'] ) {
    echo {"Ensure DB patch(es) in patch window: ${patch_window}":
      withpath => false,
    }
    $schedule = 'patchschedule'
  } else {
    $schedule = undef
  }

  # Opatchupgrade in all homes that have patches defined
  $complete_patch_list.map |$patch, $_details| { $patch.split(':')[0] }.unique.each |$home| {
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

  if ( ora_patches_installed($converted_patch_list) ) {
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

          $running_sids = $ora_install_homes[$patch_home]['running_sids']
          if $running_sids.length > 0 {
            echo {"Stopping and starting database(s) ${running_sids.join(',')} to apply DB patches on ${patch_home}":
              withpath => false,
              schedule => $schedule,
            }

            $running_sids.each |$dbname| {
              ora_listener {"Stop listener for ${dbname}":
                ensure        => 'stopped',
                instance_name => $dbname,
                before        => Ora_opatch[$patch_list_to_apply.keys],
                schedule      => $schedule,
              }

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
    $defaults = {
      ensure   => 'present',
      tmp_dir  => "${download_dir}/patches", # always use subdir, the whole directory will be removed when done
      schedule => $schedule,
    }
    if ( $is_rac ) {
      if ( $facts['ora_version'] ) {
        echo { 'Patching database software in RAC on a running system is not yet supported':
          withpath => false,
        }
      } else {
        ensure_resources('ora_opatch', $apply_patches, $defaults)
      }
    } else {
      ensure_resources('ora_opatch', $apply_patches, $defaults)
    }

    if ( $facts['ora_version'] ) {
      #
      # Oracle was running before. We stopped it to do the patching.
      # Now we need to start it again.
      #
      unless ( $is_rac ) {

        $homes_to_be_patched.each |$patch_home|  {

          $running_sids = $ora_install_homes[$patch_home]['running_sids']
          if $running_sids.length > 0 {
            $running_sids.each |$dbname| {
              ora_listener {"Start listener for ${dbname}":
                ensure        => 'running',
                instance_name => $dbname,
                require       => Ora_opatch[$apply_patches.keys],
                schedule      => $schedule,
              }

              db_control {'database start':
                ensure                  => 'start',
                instance_name           => $dbname,
                oracle_product_home_dir => $patch_home,
                os_user                 => $os_user,
                require                 => Ora_opatch[$apply_patches.keys],
                schedule                => $schedule,
              }

              -> exec { "Datapatch for ${dbname}":
                cwd         => "${patch_home}/OPatch",
                command     => "${patch_home}/OPatch/datapatch -verbose",
                environment => ["PATH=/usr/bin:/bin:${patch_home}/bin", "ORACLE_SID=${dbname}", "ORACLE_HOME=${patch_home}"],
                user        => $os_user,
                logoutput   => $logoutput,
                timeout     => 3600,
                schedule    => $schedule,
              }

              -> exec { "SQLPlus UTLRP ${dbname}":
                cwd         => $patch_home,
                command     => "${patch_home}/bin/sqlplus / as sysdba @?/rdbms/admin/utlrp",
                environment => ["PATH=/usr/bin:/bin:${patch_home}/bin", "ORACLE_SID=${dbname}", "ORACLE_HOME=${patch_home}"],
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
