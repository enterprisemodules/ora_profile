Hash with users and the public keys they will get.

Here is an example:

```yaml
ora_profile::database::rac::authenticated_nodes::keys:
  oracle_for_grid:
    ensure: present
    user: grid
    type: rsa
    key: '<public key>'
  grid_for_oracle:
    ensure: present
    user: oracle
    type: rsa
    key: '<public key>'
```
