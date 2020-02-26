This class contains the actual code secureing the database. Here you ca customise the securtiy by specifying the CIS rules you *don't* want to apply.


When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::secured_database](./secured_database.html) for an explanation on how to do this.

<%- include_attributes [
  :dbname,
  :ignore,
]%>
