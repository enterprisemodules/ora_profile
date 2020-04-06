---
title: database::firewall::firewalld
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Open up ports for Oracle using the firewalld firewall

Here is an example:

```puppet
  include ora_profile::database::firewall::firewalld
```




## Attributes



Attribute Name                                                  | Short Description                                                                          |
--------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
[manage_service](#database::firewall::firewalld_manage_service) | Using this setting you can specify if you want this module to manage the firewall service. |
[ports](#database::firewall::firewalld_ports)                   | A list of TCP ports to open in the firewall.                                               |




### ports<a name='database::firewall::firewalld_ports'>

A list of TCP ports to open in the firewall.

The default value is: `[1521]`


Type: `Hash`


[Back to overview of database::firewall::firewalld](#attributes)

### manage_service<a name='database::firewall::firewalld_manage_service'>

Using this setting you can specify if you want this module to manage the firewall service.

The default value is `true` and will make sure the firewall service is started and enabled.
Type: `Boolean`


[Back to overview of database::firewall::firewalld](#attributes)
