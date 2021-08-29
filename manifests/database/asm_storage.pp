#
# ora_profile::database::asm_storage
#
# @summary This class sets up the storage for usage by ASM.
# Here you can customize some of the attributes of your storage.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['nfs', 'asmlib', 'afd', 'raw', 'none']] storage_type
#    The type of ASM storage to use.
#    Valid values are:
#    - `nfs`
#    - `asmlib`
#    - `afd`
#    - `raw`
#    - `none`
#    The default value is: `nfs`.
#
# @param [Optional[Stdlib::Absolutepath]] nfs_mountpoint
#    The mountpoint where the NFS volume will be mounted.
#    The default value is: `/nfs_client`.
#
# @param [Optional[Stdlib::Absolutepath]] nfs_export
#    The name of the NFS volume that will be mounted to nfs_mountpoint.
#    The default value is: `/home/nfs_server_data`.
#
# @param [Optional[String[1]]] nfs_server
#    The name of the NFS server.
#    The default value is: `localhost`.
#
# @param [Optional[Hash]] disk_devices
#    The disk devices that should be used.
#    Dependant on value specified for `ora_profile::database::asm_storage::storage_type`
#    Here is an example:
#    ```yaml
#    ora_profile::database::asm_storage::disk_devices:
#      asm_data01:
#        size: 8192
#        uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000'
#        label: 'DATA1'
#    ```
#
# @param [Optional[String[1]]] scan_exclude
#    Specify which devices to exclude from scanning for ASMLib.
#    The default value is: `undef`
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::asm_storage(
  Enum['nfs','asmlib','afd','raw', 'none']
            $storage_type,
  Optional[Stdlib::Absolutepath]
            $nfs_mountpoint,
  Optional[Stdlib::Absolutepath]
            $nfs_export,
  Optional[String[1]]
            $nfs_server,
  Optional[Hash]
            $disk_devices,
  Optional[String[1]]
            $scan_exclude,
) inherits ora_profile::database {
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo {"Ensure ASM storage setup using ${storage_type} disk devices":
    withpath => false,
  }
  case $storage_type {
    'nfs': {
      unless ( $nfs_mountpoint or $nfs_export or $nfs_server) {
        fail 'Parameters nfs_mountpoint, nfs_export and nfs_server should all be specified'
      }
      class {'ora_profile::database::asm_storage::nfs':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        nfs_mountpoint  => $nfs_mountpoint,
        nfs_export      => $nfs_export,
        nfs_server      => $nfs_server,
      }
      contain ora_profile::database::asm_storage::nfs
    }
    'asmlib': {
      unless ( $disk_devices ) {
        fail 'Parameters disk_devices should be specified'
      }
      class {'ora_profile::database::asm_storage::udev':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        disk_devices    => $disk_devices,
        before          => [
          Class['ora_profile::database::asm_storage::asmlib'],
          Ora_profile::Database::Asm_storage::Partition[$disk_devices.keys]
        ],
      }
      contain ora_profile::database::asm_storage::udev
      $disk_devices.each |$device, $attributes| {
        ora_profile::database::asm_storage::partition {$device:
          raw_device => "/dev/${device}:1",
          table_type => 'gpt',
          before     => Class['ora_profile::database::asm_storage::asmlib'],
        }
      }
      class {'ora_profile::database::asm_storage::asmlib':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        scan_exclude    => $scan_exclude,
        disk_devices    => $disk_devices,
      }
      contain ora_profile::database::asm_storage::asmlib
    }
    'afd': {
      unless ( $disk_devices ) {
        fail 'Parameters disk_devices should be specified'
      }
      class {'ora_profile::database::asm_storage::udev':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        disk_devices    => $disk_devices,
      }
      contain ora_profile::database::asm_storage::udev
    }
    'raw': {
      unless ( $disk_devices ) {
        fail 'Parameters disk_devices should be specified'
      }
      class {'ora_profile::database::asm_storage::udev':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        disk_devices    => $disk_devices,
      }
      contain ora_profile::database::asm_storage::udev
    }
    'none': {
      # do nothing. Can be used for example on oracle cloud devices
    }
    default: {}
  }
}
# lint:endignore
