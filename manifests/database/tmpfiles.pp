#++--++
#
# ora_profile::tmpfiles
#
# @summary This class contains the definition all the required OS limit settings on your system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] list
#    The OS limits created for Oracle.
#    The defaults are:
#   
# First level is the config file in /etc/tmpfiles.d it will have the .conf extension
# We can group multiple directories in a configfile with mixed config types
#
#
# Example: 
# ora_profile::database::tmpfiles::list:
#  oracle:
#    - dir:      '/var/tmp/.oracle'
#      mode:     'x'
#    - dir:      '/var/tmp/test'
#      mode:     'd'
#      perm:     '0755'
#      owner:    'root'
#      group:    'root'
#      interval: '12h'
#  linux:
#    - dir:   '/tmp/.screenrc'
#      mode:  'x'
#   
#    
# use 'man 5 tmpfiles.d' for all config options
#
# Module default:
# ora_profile::database::tmpfiles::list:
#  oracle:
#    - dir: '/tmp/.oracle'
#      mode: 'x'
#    - dir: '/var/tmp/.oracle'
#      mode: 'x'
#
#
#--++--
class ora_profile::database::tmpfiles(
  Hash $list,
) {

  easy_type::debug_evaluation() # Show local variable on extended debug

  $list.map | Array $item | {
    $file = $item[0]

    $statement = $list[$file].map | Hash $item | {
        $dir      = $item[dir]
        $mode     = $item[mode]
        $perm     = $item[perm]
        $owner    = $item[owner]
        $group    = $item[group]
        $interval = $item[interval]

        "${mode} ${dir} ${perm} ${owner} ${group} ${interval}\n"

    }.reduce | $statements, $statement | { "${statements}${statement}" }

    file { "/etc/tmpfiles.d/${file}.conf":
      ensure  => 'file',
      mode    => '0750',
      owner   => 'root',
      group   => 'root',
      content => $statement,
    }
  }
}
