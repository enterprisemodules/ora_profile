#++--++

#--++--
# lint:ignore:variable_scope
class ora_profile::database::asm_patches(
  Stdlib::Absolutepath
            $grid_home,
  String[1] $patch_file,
  String[1] $opversion,
  Hash      $patch_list,
) inherits ora_profile::database {

  echo {"Ensure ASM Patch(es) on ${grid_home}":
    withpath => false,
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

  # $converted_patch_list = $patch_list.map | $i, $j | { $j['sub_patches'].map | $x | { "${i.split(':')[0]}:${x}" } }.flatten

  if ( oracle_exists($grid_home) ) {
    # Stop everything, install patches and start again
    $todo = 'this'
  } else {
    # ORACLE_HOME is not registered in oraInventory so we will install the patch using gridSetup.sh
    file { "${download_dir}/patches":
      ensure => directory,
      mode   => '0777',
    }

    $asm_version = lookup('ora_profile::database::asm_software::version')

    $patch_list.each |$patch, $props| {
      $home = split($patch, ':')[0]
      $patch_num = split($patch, ':')[1]
      archive{ "${download_dir}/${props['source']}":
        ensure       => present,
        cleanup      => true,
        creates      => "${download_dir}/patches/${patch_num}",
        extract      => true,
        extract_path => "${download_dir}/patches",
        group        => $install_group,
        user         => $grid_user,
        source       => "${source}/${props['source']}",
        before       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
        notify       => Exec["Apply ${props['type']} patch(es) ${patch_num} to ${home}"],
        require      => [
          File["${download_dir}/patches"],
          Ora_install::Opatchupgrade["ASM OPatch upgrade to ${opversion}"],
        ],
      }
      if ( has_key($props, 'sub_patches') ) {
        $sub_patches = $props['sub_patches'].map |$p| { "${download_dir}/patches/${patch_num}/${p}" }
        $apply_patches = join($sub_patches, ',')
      } else {
        $apply_patches = "${download_dir}/patches/${patch_num}"
      }
      exec{ "Apply ${props['type']} patch(es) ${patch_num} to ${home}":
        command     => case $props['type'] {
          'psu': {
            case $asm_version {
              '12.2.0.1': {
                "${home}/gridSetup.sh -applyPSU ${download_dir}/patches/${patch_num} -silent | grep -z \"Successfully applied the patch.\""
              }
              '18.0.0.0', '19.0.0.0': {
                "${home}/gridSetup.sh -applyRU ${download_dir}/patches/${patch_num} -silent | grep -z \"Successfully applied the patch.\""
              }
              default: {
                fail ("Version ${asm_version} doesn't support patching this way")
              }
            }
          }
          'one-off': {
            case $asm_version {
              '12.2.0.1', '18.0.0.0', '19.0.0.0': {
                "${home}/gridSetup.sh -applyOneOffs ${apply_patches} -silent | grep -z \"Successfully applied the patch.\""
              }
              default: {
                fail ("Version ${asm_version} doesn't support patching this way")
              }
            }
          }
          default: {
            fail ('This case doesnot have a default')
          }
        },
        refreshonly => true,
        environment => ["ORACLE_HOME=${home}", "ORACLE_BASE=${grid_base}", 'DISPLAY=:0'],
        path        => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:',
        timeout     => 0,
        user        => $grid_user,
        group       => $install_group,
        notify      => Exec["Cleanup ${download_dir}/patches/${patch_num}"],
        logoutput   => true,
      }
      exec{ "Cleanup ${download_dir}/patches/${patch_num}":
        command     => "/bin/rm -rf ${download_dir}/patches/${patch_num}",
        refreshonly => true,
      }
    }
  }
}
# lint:endignore
