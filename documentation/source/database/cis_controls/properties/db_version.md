The database version of the CIS benchmark you want to apply. Although not very logical, you **can** apply an older (or newer) database version to your database.

If you also don't specify a `db_version`, Puppet will detect the version of Oracle running and use this to determine the `db_version`. There is, however, one issue with the detection. On an initial run Puppet canot determine what the Oracle version is. In that case, the ora_cis defined type will skip applying the CIS benchmark and wait until (hopefully) the next run the version of Oracle for specified sid is available.

