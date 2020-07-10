The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.

This parameter can also be defined as Hash in case you need multiple listeners.
The keys of the hash are the database names, and for every key you can specify all valid parameters for the class.
The defaults for all key(s) in the Hash are the ones given to the class.
