---
title: database::disable thp
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the Transparent HugePages settings required for running Oracle.

As documented in Oracle support ALERT <https://support.oracle.com/epmos/faces/DocumentDisplay?id=1557478.1>,
the class will disable Transparent HugePages on RedHat os family starting with version 6.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}



