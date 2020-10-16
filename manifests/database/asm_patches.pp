#++--++
#
# ora_profile::database::asm_patches
#
# @summary This class contains the definition for the ASM patches.
# It also contains the definition of the required `Opatch` version.
#
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Stdlib::Absolutepath] grid_home
#    The ORACLE_HOME for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`
#    To customize this consistently use the hiera key `ora_profile::database::grid_home`.
#
# @param [String[1]] patch_file
#    The file containing the required Opatch version.
#    The default value is: `p6880880_122010_Linux-x86-64`
#
# @param [String[1]] opversion
#    The version of OPatch that is needed.
#    If it is not installed, Puppet will install the specfied version.
#    The default value is: `12.2.0.1.13`
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
class ora_profile::database::asm_patches(
  Stdlib::Absolutepath
            $grid_home,
  String[1] $patch_file,
  String[1] $opversion,
  Hash      $patch_list,
  Variant[Boolean,Enum['on_failure']]
            $logoutput = lookup({name => 'logoutput', default_value => 'on_failure'}),
) inherits ora_profile::database {
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $patch_list.keys.size > 0 ) {
    $patch_list.each |$patch, $props| {
      if ( ! has_key($props, 'sub_patches') ) {
        fail "The key 'sub_patches' must be specified for each patch in ora_profile::database::asm_patches::patch_list"
      }
    }
    echo {"Ensure ASM Patch(es) ${patch_list.keys.join(',')} on ${grid_home}":
      withpath => false,
    }
  }

  #
  # First make sure the correct version of opatch is installed
  #
  ora_install::opatchupgrade{"ASM OPatch upgrade to ${opversion}":
    oracle_home               => $grid_home,
    patch_file                => "${patch_file}.zip",
    opversion                 => $opversion,
    user                      => $grid_user,
    group                     => $install_group,
    puppet_download_mnt_point => $source,
    download_dir              => $download_dir,
  }

  $converted_patch_list = $patch_list.map |$patch, $props| { $props['sub_patches'].map | $sp | { "${patch.split(':')[0]}:${sp}" } }.flatten

  if ( ora_install::oracle_exists($grid_home) ) {
    if ( ora_install::ora_patches_installed($converted_patch_list) ) {
      echo { 'All ASM patches already installed. Skipping patches.':
        withpath => false,
      }
    } else {
      # Stop everything, install patches and start again
      $todo = 'this'
    }
  } else {
    # ORACLE_HOME is not registered in oraInventory so we will install the patch using gridSetup.sh on master_node
    if ( $master_node == $facts['hostname'] ) {
      file { "${download_dir}/patches":
        ensure => directory,
        mode   => '0777',
      }

      $asm_version = lookup('ora_profile::database::asm_software::version')
      $patch_list.each |$patch, $props| {
        $home = split($patch, ':')[0]
        $patch_num = split($patch, ':')[1]
        $file_name = split($props['source'], '/')[-1]

        archive{ "${download_dir}/${file_name}":
          ensure       => present,
          cleanup      => true,
          creates      => "${download_dir}/patches/${patch_num}",
          extract      => true,
          extract_path => "${download_dir}/patches",
          group        => $install_group,
          user         => $grid_user,
          source       => $props['source'],
          before       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
          notify       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
          require      => [
            File["${download_dir}/patches"],
            Ora_install::Opatchupgrade["ASM OPatch upgrade to ${opversion}"],
          ],
        }

        $sub_patches = $props['sub_patches'].map |$sp| {
          if ( $sp == $patch_num ) {
            if ( $props['type'] == 'psu' ) {
              "${download_dir}/patches/${patch_num}/${sp}"
            } else {
              "${download_dir}/patches/${patch_num}"
            }
          } else {
            "${download_dir}/patches/${patch_num}/${sp}"
          }
        }

        case $props['type'] {
          'psu': {
            case $asm_version {
              '12.2.0.1': {
                $apply_type = 'PSU'
              }
              '18.0.0.0', '19.0.0.0': {
                $apply_type = 'RU'
              }
              default: {
                fail ("Version ${asm_version} doesn't support patching this way")
              }
            }
            $apply_patches = "${download_dir}/patches/${patch_num}"
          }
          'one-off': {
            case $asm_version {
              '12.2.0.1', '18.0.0.0', '19.0.0.0': {
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

        file { "${download_dir}/patches/patch_grid_${patch_num}.sh":
          ensure  => file,
          owner   => $grid_user,
          group   => $install_group,
          mode    => '0744',
          content => epp('ora_profile/patch_grid.sh.epp',{
            'home'          => $home,
            'grid_base'     => $grid_base,
            'download_dir'  => $download_dir,
            'patch_num'     => $patch_num,
            'apply_type'    => $apply_type,
            'apply_patches' => $apply_patches,
          }),
        }

        exec{ "Apply ${props['type']} patch(es) ${patch_num} to ${home}":
          command     => "${download_dir}/patches/patch_grid_${patch_num}.sh",
          refreshonly => true,
          timeout     => 0,
          user        => $grid_user,
          group       => $install_group,
          notify      => Exec["Cleanup ${download_dir}/patches/${patch_num}"],
          require     => File["${download_dir}/patches/patch_grid_${patch_num}.sh"],
          logoutput   => $logoutput,
        }

        exec{ "Cleanup ${download_dir}/patches/${patch_num}":
          command     => "/bin/rm -rf ${download_dir}/patches/${patch_num}",
          refreshonly => true,
        }
      }
    }
  }
}
# lint:endignore
