# ora_profile::secured_db
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::secured_db
#++--++
#
# ora_profile::secured_database
#
# @summary This is a highly customizable Puppet profile class to define an Secured Oracle database on your system.
# In it's core just adding:
# 
# ```
# contain ora_profile::secured_database
# ```
# 
# Is enough to get a secured Oracle database running on your system.
# 
# This profile class is based on the more generic [`ora_profile::database`](./database.html) class, but extends this class with securing the database conforming to the Oracle Center for Internet Security (CIS) rules.
#
#--++--
class ora_profile::secured_database() {
  contain ora_profile::database
  include ora_profile::database::cis_controls
}
