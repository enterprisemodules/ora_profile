---
title: secured database
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This is a highly customizable Puppet profile class to define an Secured Oracle database on your system. In it's core just adding:

```
contain ora_profile::secured_database
```

Is enough to get a secured Oracle database running on your system.

This profile class is based on the more generic [`ora_profile::database`](./database.html) class, but extends this class with securing the database conforming to the Oracle Center for Internet Security (CIS) rules.




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)


