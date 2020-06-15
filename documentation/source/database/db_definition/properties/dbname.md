The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.

This parameter can also be defined as Hash in which case the key(s) of the Hash are the name of the database(s).
The defaults for all the database(s) in the Hash are the ones given to the db_definition class.
In addition all properties and parameters taken by ora_database can be defined in hiera data.
