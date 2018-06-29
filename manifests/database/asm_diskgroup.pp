#++--++
#
# ora_profile::asm_diskgroup
#
# @summary This class contains the code to create the ASM diskgroups.
# Here you can customize some of the attributes of your database.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] disks
#    A hash with the diskgroups that will be created.
#    The default value is:
#    ```yaml
#    ora_profile::database::asm_diskgroup::disks:
#      DATA:
#        - diskname: 'DATA_0000'
#          path: '/nfs_client/asm_sda_nfs_b1'
#        - diskname: 'DATA_0001'
#          path: '/nfs_client/asm_sda_nfs_b2'
#      RECO:
#        - diskname: 'RECO_0000'
#          path: '/nfs_client/asm_sda_nfs_b3'
#        - diskname: 'RECO_0001'
#          path: '/nfs_client/asm_sda_nfs_b4'
#    ```
#
#--++--
# lint:ignore:variable_scope
class ora_profile::database::asm_diskgroup(
  Hash    $disks         = {},
) inherits ora_profile::database {

  $disk_list = $disks.keys
  echo {"Ensure ASM diskgroup(s) ${disk_list.join(',')}":
    withpath => false,
  }

  $asm_version = $ora_profile::database::asm_software::version

  $disks.each |$diskgroup, $devices| {
    ora_asm_diskgroup { "${diskgroup}@${asm_instance_name}":
      ensure            => 'present',
      au_size           => '4',
      redundancy_type   => 'EXTERN',
      compat_asm        => $asm_version,
      compat_rdbms      => $asm_version,
      diskgroup_state   => 'MOUNTED',
      allow_disk_update => true,
      disks             => $devices,
    }
  }

}
# lint:endignore
