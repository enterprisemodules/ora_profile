# lint:ignore:parameter_documentation
#
# ora_profile::database::common
#
# @summary This class contains common variables used by more then one class.
#
#
# @param cluster_nodes
#    An array with cluster node names for RAC.
#    Example:
#    ```yaml
#    ora_profile::database::cluster_nodes:
#    - node1
#    - node2
#    ```
#
# @param db_control_provider
#    Which provider should be used for the type db_control.
#    The default value is: `sqlplus`
#    To customize this consistently use the hiera key `ora_profile::database::db_control_provider`.
#
# @param download_dir
#    The directory where the Puppet software puts all downloaded files.
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#    The default value is: `/install`
#    To customize this consistently use the hiera key `ora_profile::database::download_dir`.
#
# @param grid_base
#    The ORACLE_BASE for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/admin`
#    To customize this consistently use the hiera key `ora_profile::database::grid_base`.
#
# @param grid_home
#    The ORACLE_HOME for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`
#    To customize this consistently use the hiera key `ora_profile::database::grid_home`.
#
# @param grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param master_node
#    The first node in RAC.
#    This  is the node where the other nodes will clone the software installations from.
#    To customize this consistently use the hiera key `ora_profile::database::master_node`.
#
# @param ora_inventory_dir
#    The directory that contains the oracle inventory.
#    The default value is: `/oracle_base/oraInventory`
#    To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.
#
# @param oracle_user_password
#    The password for the oracle os user.
#    Only applicable for Windows systems.
#    To customize this consistently use the hiera key `ora_profile::database::oracle_user_password`.
#
# @param patch_levels
#    Defines all the patch levels for both database and grid infrastructure formost common versions 12.
#    2, 18c and 19c.
#    The default values look like the example below.
#    In addition to all the parameters for ora_opatch, except sub_patches and source, (see [ora_opatch]https://www.enterprisemodules.com/docs/ora_install/ora_opatch.html) the following parameters can be specified:
#            db_sub_patches: Array of sub patches applicable for database installations
#            grid_sub_patches: Array of sub patches applicable for grid infrastructure installations
#            file: zipfile that contains the patch
#            type: 'one-off' or 'psu'
#    an example on how to use this is:
#    ```yaml
#    ora_profile::database::patch_levels:
#      '19.0.0.0':
#        OCT2020RU:
#          "31750108-GIRU-19.9.0.0.201020":
#            file:                  "p31750108_190000_Linux-x86-64.zip"
#            db_sub_patches:        ['31771877','31772784']
#            grid_sub_patches:      ['31771877','31772784','31773437','31780966']
#    ```
#
# @param patch_window
#    The patch window in which you want to do the patching.
#    Every time puppet runs outside of this patcn windows, puppet will detect the patches are not installed, but puppet will not shutdown the database and apply the patches.
#    an example on how to use this is:
#            patch_window => '2:00 - 4:00'
#
# @param source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param temp_dir
#    Directory to use for temporary files.
#
# @param version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::common () {
  $version              = lookup('ora_profile::database::version', Ora_Install::Version)
  $download_dir         = lookup('ora_profile::database::download_dir', String[1])
  $install_group        = lookup('ora_profile::database::install_group', String[1])
  $master_node          = lookup('ora_profile::database::master_node', Optional[String[1]], undef, $facts['networking']['hostname'])
  $ora_inventory_dir    = lookup('ora_profile::database::ora_inventory_dir', String[1])
  $grid_home            = lookup('ora_profile::database::grid_home', String[1])
  $grid_base            = lookup('ora_profile::database::grid_base', String[1])
  $grid_user            = lookup('ora_profile::database::grid_user', String[1])
  $temp_dir             = lookup('ora_profile::database::temp_dir', String[1])
  $source               = lookup('ora_profile::database::source', String[1])
  $cluster_nodes        = lookup('ora_profile::database::cluster_nodes', Optional[Array])
  $oracle_user_password = lookup('ora_profile::database::oracle_user_password', Optional[String[1]], undef, undef)
  $db_control_provider  = lookup('ora_profile::database::db_control_provider', Optional[String[1]])
  $patch_window         = lookup('ora_profile::database::patch_window', String[1])
  $patch_levels         = lookup('ora_profile::database::patch_levels', Hash)
  $is_rac               = !empty($cluster_nodes)
  $is_linux             = $facts['kernel'] == 'Linux'
  $is_windows           = $facts['kernel'] == 'Windows'
  # lint:endignore:parameter_documentation
}
