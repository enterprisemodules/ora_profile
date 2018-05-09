# ora_profile::database::db_patches
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_patches
class ora_profile::database::db_patches(
  String[1] $patch_file,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $opversion,
  String[1] $install_group,
  String[1] $os_user,
  String[1] $source,
  Hash      $patch_list,
) inherits ora_profile::database {

  echo {"DB patches on ${oracle_home}":
    withpath => false,
  }

  #
  # First make sure the correct version of opatch is installed
  #  
  ora_install::opatchupgrade{$patch_file:
    oracle_home               => $oracle_home,
    patch_file                => "${patch_file}.zip",
    opversion                 => $opversion,
    user                      => $os_user,
    group                     => $install_group,
    download_dir              => '/tmp',
    puppet_download_mnt_point => $source,
  }

  #
  # Now start with the patches themselfs
  #
  $converted_patch_list = $patch_list.map | $i, $j | { $j['sub_patches'].map | $x | { "${i.split(':')[0]}:${x}" } }.flatten

  if ora_patches_installed($converted_patch_list) {
    echo { 'All Oracle patches already installed. Skipping patches.':
      withpath => false,
    }
  } else {
    #
    # No support yet for patching a running database
    #
    #
    #
    # Some patches need to be installed
    #
    $defaults = {
      ensure  => 'present',
      tmp_dir => '/tmp/patch',
    }
    create_resources('ora_opatch', $patch_list, $defaults)
  }
}
