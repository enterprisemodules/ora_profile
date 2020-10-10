# ora_profile::database::asm_storage::partition
#
#++--++
#
# ora_profile::database::asm_storage::partition
#
# @summary This class adds partition table and partitions to specified device.
# .
# 
# Here is an example:
# 
# ```puppet
#   include ora_profile::database::asm_storage::partition
# ```
#
# @param [Stdlib::Absolutepath] raw_device
#    The device that needs to be partitioned.
#
# @param [Enum['gpt', 'msdos']] table_type
#    The type of partition table.
#
# @param [Boolean] wait_for_device
#    Should we wait for the device to be available?
#
# @param [Optional[Easy_type::Size]] start
#    The start point of the partition.
#
# @param [Optional[Easy_type::Size]] end
#    The end point of the partition.
#
#--++--
define ora_profile::database::asm_storage::partition(
  Stdlib::Absolutepath
            $raw_device,
  Enum['gpt','msdos']
            $table_type      = 'msdos',
  Boolean   $wait_for_device = false,
  Optional[Easy_type::Size]
            $start           = undef,
  Optional[Easy_type::Size]
            $end             = undef,
) {

  $device = split($raw_device,':')[0]

  easy_type::debug_evaluation() # Show local variable on extended debug

  if ( $wait_for_device ) {
    sleep { "until_${device}_available":
      bedtime       => '120',                                     # how long to sleep for
      wakeupfor     => "/usr/bin/test -b ${device}",              # an optional test, run in a shell
      dozetime      => '5',                                       # dozetime for the test interval, defaults to 10s
      failontimeout => true,                                      # whether to fail the resource if the test times out
      refreshonly   => false,
    }
  }

  partition_table { $device:
    ensure => $table_type,
    notify => Exec["apply_udev_rules_partition_${device}"],
  }

  -> partition { $raw_device:
    ensure    => 'present',
    part_type => 'primary',
    start     => $start,
    end       => $end,
    notify    => Exec["apply_udev_rules_partition_${device}"],
  }

  exec { "apply_udev_rules_partition_${device}":
    command     => '/sbin/udevadm control --reload-rules && /sbin/udevadm trigger',
    refreshonly => true,
  }

}
