#++--++

#--++--
class ora_profile::database::asm_storage(
  Enum['nfs','asmlib','afd']
            $storage_type,
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Array[Stdlib::Absolutepath]
            $nfs_files,
  Stdlib::Absolutepath
            $nfs_mointpoint,
  Stdlib::Absolutepath
            $nfs_export,
  String[1] $nfs_server,
) inherits ora_profile::database {

  echo {"Ensure ASM storage setup using ${storage_type}":
    withpath => false,
  }
  case $storage_type {
    'nfs': {
      class {'ora_profile::database::asm_storage::nfs':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        nfs_files       => $nfs_files,
        nfs_mointpoint  => $nfs_mointpoint,
        nfs_export      => $nfs_export,
        nfs_server      => $nfs_server,
      }
    }
    'asmlib': {
      echo {"Storage type ${storage_type} not implemented yet":
        withpath => false,
      }
    }
    'afd': {
      echo {"Storage type ${storage_type} not implemented yet":
        withpath => false,
      }
    }
    default: {}
  }
}
