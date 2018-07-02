The type of grid.

Valid values are:
- `HA_CONFIG`
- `CRS_CONFIG`
- `HA_SWONLY`   (versions > 11)
- `UPGRADE`
- `CRS_SWONLY`

The default value is: `HA_CONFIG`

To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_type`.
