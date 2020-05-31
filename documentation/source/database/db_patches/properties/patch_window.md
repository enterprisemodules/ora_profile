The patch window in which you want to do the patching. Every time puppet runs outside of this patcn windows, puppet will detect the patches are not installed, but puppet will not shutdown the database and apply the patches.

an example on how to use this is:

        patch_window => '2:00 - 4:00'
