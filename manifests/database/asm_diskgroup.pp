#
# ora_profile::database::asm_diskgroup
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
#        disks:
#        - diskname: 'DATA_0000'
#          path: '/nfs_client/asm_sda_nfs_b1'
#        - diskname: 'DATA_0001'
#          path: '/nfs_client/asm_sda_nfs_b2'
#      RECO:
#        disks:
#        - diskname: 'RECO_0000'
#          path: '/nfs_client/asm_sda_nfs_b3'
#        - diskname: 'RECO_0001'
#          path: '/nfs_client/asm_sda_nfs_b4'
#    ```
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::asm_diskgroup(
  Hash    $disks         = {},
) inherits ora_profile::database {
# lint:ignore:variable_scope

  $disk_list = $disks.keys
  echo {"Ensure ASM diskgroup(s) ${disk_list.join(',')}":
    withpath => false,
  }

  $asm_version = lookup('ora_profile::database::asm_software::version')

  $diskgroups = suffix($disks, "@${asm_instance_name}")

  easy_type::debug_evaluation() # Show local variable on extended debug

  $diskgroups.each |String $diskgroup, Hash $diskgroup_props = {}| {
    ora_asm_diskgroup {
      default:
        ensure            => present,
        allow_disk_update => true,
        au_size           => 4,
        compat_asm        => $asm_version,
        compat_rdbms      => $asm_version,
        diskgroup_state   => 'MOUNTED',
        redundancy_type   => 'EXTERNAL',
      ;
      $diskgroup:
        * => $diskgroup_props,
    }
  }

}
# lint:endignore
