#
# ora_profile::database::asm_patches
#
# @summary This class contains the definition for the ASM patches.
# It also contains the definition of the required `Opatch` version.
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
# @param [String[1]] patch_file
#    The file containing the required Opatch version.
#    The default value is: `p6880880_122010_Linux-x86-64`
#
# @param [String[1]] opversion
#    The version of OPatch that is needed.
#    If it is not installed, Puppet will install the specfied version.
#    The default value is: `12.2.0.1.33`
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
class ora_profile::database::asm_patches (
# lint:ignore:strict_indent
# lint:ignore:lookup_in_parameter
  String[1] $level,
  String[1] $opversion,
  String[1] $patch_file,
  Hash      $patch_list,
  Variant[Boolean, Enum['on_failure']]
            $logoutput = lookup({ name => 'logoutput', default_value => 'on_failure' }),
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
# lint:endignore:lookup_in_parameter
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  # Always execute Ora_install::Opatchupgrade before any Ora_opatch in this class (tag = asm_patches)
  Ora_install::Opatchupgrade["ASM OPatch upgrade to ${opversion}"] -> Ora_opatch <| tag == 'asm_patches' |>

  #
  # First make sure the correct version of opatch is installed
  #
  ora_install::opatchupgrade { "ASM OPatch upgrade to ${opversion}":
    oracle_home               => $grid_home,
    patch_file                => "${patch_file}.zip",
    opversion                 => $opversion,
    user                      => $grid_user,
    group                     => $install_group,
    puppet_download_mnt_point => $source,
    download_dir              => $download_dir,
  }

  $asm_version = lookup('ora_profile::database::asm_software::version', String)

  $patch_level_list = ora_profile::level_to_patches( $level, $source, $opversion, $grid_home, $asm_version, 'grid' )
  $patch_bundle_id = ora_profile::level_to_bundle( $level, $asm_version )

  $complete_patch_list = ($patch_level_list + $patch_list)

  schedule { 'asm_patchschedule':
    range  => $patch_window,
  }

  if ( $facts['ora_version'] ) {
    echo { "Ensure ASM patch(es) in patch window: ${patch_window}":
      withpath => false,
    }
    $schedule = 'asm_patchschedule'
  } else {
    $schedule = undef
  }

  if ( $patch_list.keys.size > 0 ) {
    $patch_list.each |$patch, $props| {
      if ( ! 'sub_patches' in $props ) {
        fail "The key 'sub_patches' must be specified for each patch in ora_profile::database::asm_patches::patch_list"
      }
    }
    if ( $level == 'NONE' ) {
      echo { "Ensure ASM Patch(es) ${patch_list.keys.join(',')} on ${grid_home}":
        withpath => false,
      }
    } else {
      echo { "Ensure ASM patch level ${level} (bundle ${patch_bundle_id}) on ${grid_home} and patch list ${patch_list.keys.join(',')}":
        withpath => false,
      }
    }
  } else {
    echo { "Ensure ASM patch level ${level} (bundle ${patch_bundle_id}) on ${grid_home}":
      withpath => false,
    }
  }

  # patch_list_to_apply is the hash with patches that need to be applied, without patches that have already been applied
  $patch_list_to_apply = ora_install::ora_patches_missing($complete_patch_list, 'grid')

  if ( ora_install::oracle_exists($grid_home) ) {
    if ( $patch_list_to_apply.empty ) {
      echo { 'All ASM patches already installed. Skipping patches.':
        withpath => false,
      }
    } else {
      #
      # Some patches need to be installed
      #
      $apply_patches = $patch_list_to_apply.map |String $patch_name, Hash $patch_details| {
        if ( $patch_details['type'] == 'psu' ) {
          $provider = { 'provider' => 'opatchauto' }
        } elsif ( $patch_details['type'] == 'one-off' ) {
          $provider = { 'provider' => 'regular' }
        } else {
          fail "Wrong type (${patch_details['type']}) specified for patch ${patch_name}"
        }
        $current_patch = {
          # Add provider
          # Remove sub_patches because for opatchauto (type=psu) we cannot feed sub_patches to ora_opatch
          #                            for opatch (type=one-off) we cannot have sub_patches the same as in title
          # Remove type because it's not supported by ora_opatch
          $patch_name => ($patch_details + $provider - 'sub_patches' - 'type'),
        }
        $current_patch
      }.reduce({}) |$memo, $hash| { $memo + $hash } # Turn Array of Hashes into Hash

      echo { "Apply ASM patch(es) ${apply_patches.keys.join(',')} CAUSING DOWNTIME ON THIS NODE":
        withpath => false,
        schedule => $schedule,
      }

      # Split the patches into one-off's and psu
      $one_off_patches = $apply_patches.filter |$patch, $patch_details| { $patch_details['provider'] == 'regular' }
      $psu_patches = $apply_patches.filter |$patch, $patch_details| { $patch_details['provider'] == 'opatchauto' }

      # Apply the PSU patches first using opatchauto which means the stopping and starting is taken care of by the utility
      $psu_patches.each | String $patch, Hash $patch_properties = {} | {
        ora_opatch {
          default:
            ensure   => present,
            tmp_dir  => "${download_dir}/asm_patches", # always use subdir, the whole directory will be removed when done
            schedule => $schedule,
            tag      => 'asm_patches',
            ;
          $patch:
            * => $patch_properties,
        }
      }

      # Apply the one-off patches using the regular provider which means we have to stop everything ourselves
      unless ( $one_off_patches.empty ) {
        if ( $is_rac ) {
          $facility = 'crs'
        } else {
          $facility = 'has'
        }
        exec { "root${facility}.sh -prepatch":
          command     => "${grid_home}/crs/install/root${facility}.sh -prepatch",
          environment => ["ORACLE_HOME=${grid_home}","ORACLE_BASE=${grid_base}"],
          timeout     => 900,
          logoutput   => $logoutput,
          require     => Ora_opatch[$psu_patches.keys],
        }
        $one_off_patches.each | String $patch, Hash $patch_properties = {} | {
          ora_opatch {
            default:
              ensure   => present,
              tmp_dir  => "${download_dir}/asm_patches", # always use subdir, the whole directory will be removed when done
              schedule => $schedule,
              tag      => 'asm_patches',
              require  => [
                Exec["root${facility}.sh -prepatch"],
                Ora_opatch[$psu_patches.keys]
              ],
              before   => Exec['rootadd_rdbms.sh'],
              ;
            $patch:
              * => $patch_properties,
          }
        }
        exec { 'rootadd_rdbms.sh':
          command     => "${grid_home}/rdbms/install/rootadd_rdbms.sh",
          environment => ["ORACLE_HOME=${grid_home}","ORACLE_BASE=${grid_base}"],
          before      => Exec["root${facility}.sh -postpatch"],
          logoutput   => $logoutput,
          require     => Ora_opatch[$psu_patches.keys],
        }
        exec { "root${facility}.sh -postpatch":
          command     => "${grid_home}/crs/install/root${facility}.sh -postpatch",
          environment => ["ORACLE_HOME=${grid_home}","ORACLE_BASE=${grid_base}"],
          timeout     => 900,
          logoutput   => $logoutput,
          require     => [
            Exec['rootadd_rdbms.sh'],
            Ora_opatch[$psu_patches.keys]
          ],
        }
      }
    }
  } else {
    # ORACLE_HOME is not registered in oraInventory so we will install the patch using gridSetup.sh on master_node
    if ( $master_node == $facts['networking']['hostname'] ) {
      # lint:ignore:world_writable_files
      file { "${download_dir}/asm_patches":
        ensure => directory,
        mode   => '0777',
      }
      # lint:endignore:world_writable_files

      $complete_patch_list.each |$patch, $props| {
        $home = split($patch, ':')[0]
        $patch_num = split($patch, ':')[1]
        $file_name = split($props['source'], '/')[-1]

        archive { "${download_dir}/${file_name}":
          ensure       => present,
          cleanup      => true,
          creates      => "${download_dir}/asm_patches/${patch_num}",
          extract      => true,
          extract_path => "${download_dir}/asm_patches",
          group        => $install_group,
          user         => $grid_user,
          source       => $props['source'],
          before       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
          notify       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
          require      => [
            File["${download_dir}/asm_patches"],
            Ora_install::Opatchupgrade["ASM OPatch upgrade to ${opversion}"],
          ],
        }

        $sub_patches = $props['sub_patches'].map |$sp| {
          if ( $sp == $patch_num ) {
            if ( $props['type'] == 'psu' ) {
              "${download_dir}/asm_patches/${patch_num}/${sp}"
            } else {
              "${download_dir}/asm_patches/${patch_num}"
            }
          } else {
            "${download_dir}/asm_patches/${patch_num}/${sp}"
          }
        }

        case $props['type'] {
          'psu': {
            case $asm_version {
              '12.2.0.1': {
                $apply_type = 'PSU'
              }
              '18.0.0.0', '19.0.0.0', '21.0.0.0': {
                $apply_type = 'RU'
              }
              default: {
                fail ("Version ${asm_version} doesn't support patching this way")
              }
            }
            $apply_patches = "${download_dir}/asm_patches/${patch_num}"
          }
          'one-off': {
            case $asm_version {
              '12.2.0.1', '18.0.0.0', '19.0.0.0', '21.0.0.0': {
                $apply_type = 'OneOffs'
              }
              default: {
                fail ("Version ${asm_version} doesn't support patching this way")
              }
            }
            $apply_patches = join($sub_patches, ',')
          }
          default: {
            fail ("Unknown patch type (${$props['type']}) specified.")
          }
        }

        file { "${download_dir}/asm_patches/patch_grid_${patch_num}.sh":
          ensure  => file,
          owner   => $grid_user,
          group   => $install_group,
          mode    => '0744',
          content => epp('ora_profile/patch_grid.sh.epp', {
              'home'          => $home,
              'grid_base'     => $grid_base,
              'download_dir'  => $download_dir,
              'patch_num'     => $patch_num,
              'apply_type'    => $apply_type,
              'apply_patches' => $apply_patches,
          }),
        }

        exec { "Apply ${props['type']} patch(es) ${patch_num} to ${home}":
          command     => "${download_dir}/asm_patches/patch_grid_${patch_num}.sh",
          refreshonly => true,
          timeout     => 0,
          user        => $grid_user,
          group       => $install_group,
          notify      => Exec["Cleanup ${download_dir}/asm_patches/${patch_num}"],
          require     => File["${download_dir}/asm_patches/patch_grid_${patch_num}.sh"],
          logoutput   => $logoutput,
        }

        exec { "Cleanup ${download_dir}/asm_patches/${patch_num}":
          command     => "/bin/rm -rf ${download_dir}/asm_patches/${patch_num}",
          refreshonly => true,
        }
      }
    }
  }
}
# lint:endignore
