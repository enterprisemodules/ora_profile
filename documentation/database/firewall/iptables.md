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




## Attributes



Attribute Name                                                 | Short Description                                                                          |
-------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
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
