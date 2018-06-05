#++--++

#--++--
class ora_profile::database::asm_diskgroup(
  Hash    $disks         = {},
)
{
  $disk_list = $disks.keys
  echo {"Ensure ASM diskgroup(s) ${disk_list.join(',')}":
    withpath => false,
  }

  $asm_version = $ora_profile::database::asm_software::version

  $disks.each |$diskgroup, $devices| {
    ora_asm_diskgroup { "${diskgroup}@+ASM":
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
