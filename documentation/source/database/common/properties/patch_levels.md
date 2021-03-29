Defines all the patch levels for both database and grid infrastructure formost common versions 12.2, 18c and 19c.
The default values look like the example below.
In addition to all the parameters for ora_opatch, except sub_patches and source, (see [ora_opatch]https://www.enterprisemodules.com/docs/ora_install/ora_opatch.html) the following parameters can be specified:

        db_sub_patches: Array of sub patches applicable for database installations
        grid_sub_patches: Array of sub patches applicable for grid infrastructure installations
        file: zipfile that contains the patch
        type: 'one-off' or 'psu'

an example on how to use this is:

```yaml
ora_profile::database::patch_levels:
  '19.0.0.0':
    OCT2020RU:
      "31750108-GIRU-19.9.0.0.201020":
        file:                  "p31750108_190000_Linux-x86-64.zip"
        db_sub_patches:        ['31771877','31772784']
        grid_sub_patches:      ['31771877','31772784','31773437','31780966']

```
