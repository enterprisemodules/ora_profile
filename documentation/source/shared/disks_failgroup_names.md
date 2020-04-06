A comma seperated list of device and failure group name.

Valid values are:

- `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3`                                 (NORMAL redundancy)
- `/dev/sdb,,/dev/sdc,,/dev/sdd,,/dev/sde,`                                         (EXTERNAL redundancy)
- `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3,/dev/sde,CRSFG4,/dev/sdf,CRSFG5` (HIGH redundancy)

The default value is: `/nfs_client/asm_sda_nfs_b1,`
