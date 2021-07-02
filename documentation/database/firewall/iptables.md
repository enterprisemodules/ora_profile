---
title: database::firewall::iptables
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Open up ports for Oracle using the iptables

Here is an example:

```puppet
  include ora_profile::database::firewall::iptables
```





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                 | Short Description                                                                          |
-------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
[cluster_nodes](#database::firewall::iptables_cluster_nodes)   | An array with cluster node names for RAC.                                                  |
[manage_service](#database::firewall::iptables_manage_service) | Using this setting you can specify if you want this module to manage the firewall service. |
[ports](#database::firewall::iptables_ports)                   | A list of TCP ports to open in the firewall.                                               |




### ports<a name='database::firewall::iptables_ports'>

A list of TCP ports to open in the firewall.

The default value is: `[1521]`


Type: `Hash`


[Back to overview of database::firewall::iptables](#attributes)

### manage_service<a name='database::firewall::iptables_manage_service'>

Using this setting you can specify if you want this module to manage the firewall service.

The default value is `true` and will make sure the firewall service is started and enabled.
Type: `Boolean`


[Back to overview of database::firewall::iptables](#attributes)

### cluster_nodes<a name='database::firewall::iptables_cluster_nodes'>

An array with cluster node names for RAC.

Example:
```yaml
ora_profile::database::cluster_nodes:
- node1
- node2
```

Type: `Optional[Array]`


[Back to overview of database::firewall::iptables](#attributes)
