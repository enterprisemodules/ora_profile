# ora_profile::database::asm_storage::nfs
#
# Configure NFS storage
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::asm_storage::nfs
class ora_profile::database::asm_storage::nfs(
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Stdlib::Absolutepath
            $nfs_mountpoint,
  Stdlib::Absolutepath
            $nfs_export,
  String[1] $nfs_server,
)
{

  file { $nfs_mountpoint:
    ensure  => directory,
    recurse => false,
    replace => false,
    mode    => '0775',
    owner   => $grid_user,
    group   => $grid_admingroup,
  }

  -> nfs::client::mount { $nfs_mountpoint:
    server      => $nfs_server,
    share       => $nfs_export,
    remounts    => true,
    atboot      => true,
    nfs_v4      => false,
    options_nfs => '_netdev,rw,bg,hard,nointr,rsize=65536,wsize=65536,tcp,timeo=600,noatime',
  }
}
