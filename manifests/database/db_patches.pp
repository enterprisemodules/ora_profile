#++--++
#
# ora_profile::db_patches
#
# @summary This class contains the definition for the Oracle patches.
# It also contains the definition of the required `Opatch` version.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [String[1]] patch_file
#    The file containing the required Opatch version.
#    The default value is: `p6880880_121010_Linux-x86-64_12.1.0.1.10`
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistenly use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] opversion
#    The version of OPatch that is needed.
#    If it is not installed, Puppet will install the specfied version.
#    The default value is: `12.1.0.1.10`
#
# @param [String[1]] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistenly use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistenly use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistenly use the hiera key `ora_profile::database::source`.
#
# @param [Hash] patch_list
#    The list of patches to apply.
#    The default value is : `{}`
#
#--++--
class ora_profile::database::db_patches(
  String[1] $dbname,
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
    $version_data = $::ora_version.filter |$data| {$data['sid'] == '$dbname'}
    if $version_data != [] {
      #
      # The idea here is that when the fact ora_version for current instance is filled,
      # the database is up and running. We want to stop the database before applying the patches.
      #  So that is why we stop the database
      #
      echo {"Stopping and starting database to apply DB patches on ${oracle_home}":
        withpath => false,
      }

      db_control {'database stop':
        ensure                  => 'stop',
        instance_name           => $dbname,
        oracle_product_home_dir => $oracle_home,
        os_user                 => $os_user,
        before                  => Ora_opatch[$patch_list.keys]
      }

      db_listener {'listener stop':
        ensure          => 'stop',
        oracle_home_dir => $oracle_home,
        os_user         => $os_user,
        before          => Ora_opatch[$patch_list.keys],
      }
    }
    #
    # Some patches need to be installed
    #
    $defaults = {
      ensure     => 'present',
      require    => Ora_install::Opatchupgrade[$patch_file],
    }
    create_resources('ora_opatch', $patch_list, $defaults)

    if $version_data != [] {
      #
      # Oracle was running before. We stopped it to do the patching. Now
      # we need to restart it again.
      #
      db_control {'database start':
        ensure                  => 'start',
        instance_name           => $dbname,
        oracle_product_home_dir => $oracle_home,
        os_user                 => $os_user,
        require                 => Ora_opatch[$patch_list.keys]
      }

      db_listener {'listener start':
        ensure          => 'start',
        oracle_home_dir => $oracle_home,
        os_user         => $os_user,
        require         => Ora_opatch[$patch_list.keys]
      }
    }
  }

}
