A hash with the diskgroups that will be created.

The default value is:

```yaml
ora_profile::database::asm_diskgroup::disks:
  DATA:
    disks:
    - diskname: 'DATA_0000'
      path: '/nfs_client/asm_sda_nfs_b1'
    - diskname: 'DATA_0001'
      path: '/nfs_client/asm_sda_nfs_b2'
  RECO:
    disks:
    - diskname: 'RECO_0000'
      path: '/nfs_client/asm_sda_nfs_b3'
    - diskname: 'RECO_0001'
      path: '/nfs_client/asm_sda_nfs_b4'

```