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
#    The default value is: `p6880880_121010_Linux-x86-64_12.1.0.1.10`
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] opversion
#    The version of OPatch that is needed.
#    If it is not installed, Puppet will install the specfied version.
#    The default value is: `12.1.0.1.10`
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
) inherits ora_profile::database {
# lint:ignore:variable_scope

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
      echo { "Ensure DB patch level ${level} ${ojvm_msg} and patch list ${patch_list.keys.join(',')} on ${oracle_home}":
        withpath => false,
      }
    }
  } else {
    echo { "Ensure DB patch level ${level} ${ojvm_msg} on ${oracle_home}":
      withpath => false,
    }
  }

  #
  # First make sure the correct version of opatch is installed
  #
  ora_install::opatchupgrade{"DB OPatch upgrade to ${opversion}":
    oracle_home               => $oracle_home,
    patch_file                => "${patch_file}.zip",
    opversion                 => $opversion,
    user                      => $os_user,
    group                     => $install_group,
    puppet_download_mnt_point => $source,
    download_dir              => $download_dir,
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
  $converted_patch_list = $complete_patch_list.map | $i, $j | { $j['sub_patches'].map | $x | { "${i.split(':')[0]}:${x}" } }.flatten.unique
  if ( $converted_patch_list.length > 0 ) {
    echo {"Ensure DB patch(es) ${converted_patch_list.join(',')} on ${oracle_home}":
      withpath => false,
    }
  }

  $patch_window = lookup('profile::db_patches::patch_window', String, 'first', '0:00 - 23:59')

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

  if ( ora_patches_installed($converted_patch_list) ) {
    if ( $converted_patch_list.length > 0 ) {
      echo { 'All DB patches already installed. Skipping patches.':
        withpath => false,
      }
    }
  } else {
    if ( $facts['ora_version'] ) {

      unless ( $is_rac ) {
        $running_sids = $facts['ora_install_homes'][$oracle_home]['running_sids']
        echo {"Stopping and starting database(s) ${running_sids.join(',')} to apply DB patches on ${oracle_home}":
          withpath => false,
          schedule => $schedule,
        }

        $running_sids.each |$dbname| {
          ora_listener {"Stop listener for ${dbname}":
            ensure        => 'stopped',
            instance_name => $dbname,
            before        => Ora_opatch[$complete_patch_list.keys],
            schedule      => $schedule,
          }

          db_control {"database stop ${dbname}":
            ensure                  => 'stop',
            instance_name           => $dbname,
            oracle_product_home_dir => $oracle_home,
            os_user                 => $os_user,
            provider                => $db_control_provider,
            before                  => Ora_opatch[$complete_patch_list.keys],
            schedule                => $schedule,
          }
        }
      }
    }

    #
    # Some patches need to be installed
    #
    $defaults = {
      ensure   => 'present',
      require  => Ora_install::Opatchupgrade["DB OPatch upgrade to ${opversion}"],
      tmp_dir  => "${download_dir}/patches",                                       # always use subdir, the whole directory will be removed when done
      schedule => $schedule,
    }
    if ( $is_rac ) {
      if ( $facts['ora_version'] ) {
        echo { 'Patching database software in RAC on a running system is not yet supported':
          withpath => false,
        }
      } else {
        ensure_resources('ora_opatch', $complete_patch_list, $defaults)
      }
    } else {
      ensure_resources('ora_opatch', $complete_patch_list, $defaults)
    }

    if ( $facts['ora_version'] ) {
      #
      # Oracle was running before. We stopped it to do the patching.
      # Now we need to start it again.
      #
      unless ( $is_rac ) {
        $running_sids.each |$dbname| {
          ora_listener {"Start listener for ${dbname}":
            ensure        => 'running',
            instance_name => $dbname,
            require       => Ora_opatch[$complete_patch_list.keys],
            schedule      => $schedule,
          }

          db_control {'database start':
            ensure                  => 'start',
            instance_name           => $dbname,
            oracle_product_home_dir => $oracle_home,
            os_user                 => $os_user,
            require                 => Ora_opatch[$complete_patch_list.keys],
            schedule                => $schedule,
          }
          -> exec { "Datapatch for ${dbname}":
            cwd         => "${oracle_home}/OPatch",
            command     => "${oracle_home}/OPatch/datapatch -verbose",
            environment => ["PATH=/usr/bin:/bin:${oracle_home}/bin", "ORACLE_SID=${dbname}", "ORACLE_HOME=${oracle_home}"],
            user        => $os_user,
            logoutput   => $logoutput,
            timeout     => 3600,
            schedule    => $schedule,
          }
          -> exec { "SQLPlus UTLRP ${dbname}":
            cwd         => $oracle_home,
            command     => "${oracle_home}/bin/sqlplus / as sysdba @?/rdbms/admin/utlrp",
            environment => ["PATH=/usr/bin:/bin:${oracle_home}/bin", "ORACLE_SID=${dbname}", "ORACLE_HOME=${oracle_home}"],
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
# lint:endignore
