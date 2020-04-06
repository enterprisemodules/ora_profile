#++--++
#
# ora_profile::database::asm_storage::nfs
#
# @summary This class will create the specified mountpoint and mount the nfs share there.
# Here is an example:
# 
# ```puppet
#   include ora_profile::database::asm_storage::nfs
# ```
#
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_admingroup
#    The OS group to use for ASM admin.
#    The default value is: `asmadmin`
#
# @param [Stdlib::Absolutepath] nfs_mountpoint
#    The mountpoint where the NFS volume will be mounted.
#    The default value is: `/nfs_client`.
#
# @param [Stdlib::Absolutepath] nfs_export
#    The name of the NFS volume that will be mounted to nfs_mountpoint.
#    The default value is: `/home/nfs_server_data`.
#
# @param [String[1]] nfs_server
#    The name of the NFS server.
#    The default value is: `localhost`.
#
#--++--
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
