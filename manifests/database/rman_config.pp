#
# ora_profile::database::rman_config
#
# @summary This class contains the definition for all the tablespaces you'd like on your system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] settings
#    The settings you wish to apply on your database(s).
#    For example:
#    ```yaml
#    ora_profile::database::rman_config::settings:
#      DB122:
#        archivelog_backup_copies:
#          DISK: '1'
#        backup_optimization: 'ON'
#        channel:
#          DISK:
#            '1': "FORMAT '/u01/backup/DB122_1_%U' MAXPIECESIZE 1024M RATE 1G"
#            '2': "FORMAT '/u01/backup/DB122_2_%U' MAXPIECESIZE 1024M RATE 1G"
#        controlfile_autobackup: 'ON'
#        controlfile_autobackup_format:
#          DISK: '/u01/backup/DB122_%F'
#        device:
#          DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
#      DB180:
#        archivelog_backup_copies:
#          DISK: '1'
#        backup_optimization: 'ON'
#        controlfile_autobackup: 'ON'
#        controlfile_autobackup_format:
#          DISK: '/u01/backup/DB180_%F'
#        device:
#          DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
#      DB190:
#        archivelog_backup_copies:
#          DISK: '1'
#        backup_optimization: 'ON'
#        controlfile_autobackup: 'ON'
#        controlfile_autobackup_format:
#          DISK: '/u01/backup/DB190_%F'
#        device:
#          DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
#      DB210:
#        archivelog_backup_copies:
#          DISK: '1'
#        backup_optimization: 'ON'
#        controlfile_autobackup: 'ON'
#        controlfile_autobackup_format:
#          DISK: '/u01/backup/DB210_%F'
#        device:
#          DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
#    ```
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::rman_config (
  Hash $settings,
) {
  easy_type::debug_evaluation() # Show local variable on extended debug

  if $settings.keys.size > 0 {
    $settings.keys.sort.each |$db| {
      echo { "Ensure RMAN config for database ${db}":
        withpath => false,
      }
    }
  }
  #
  # This is a simple way to get started. It is easy to get started, but
  # soon your hiera yaml become a nigtmare. Our advise is when you need
  # to let puppet manage your tablespaces, to override this class and
  # add your own puppet implementation. This is much better maintainable
  # and adds more consistency,
  #
  ensure_resources(ora_rman_config, $settings)
}
