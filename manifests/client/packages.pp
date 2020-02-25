#++--++
#
#
#--++--
class ora_profile::client::packages(
  Hash $list,
) {

  if $list.size > 0 {
    $packages = $list.keys
    echo {"Ensure Packages(s) ${packages.join(',')}":
      withpath => false,
    }
  }

  ensure_packages($list)
}
