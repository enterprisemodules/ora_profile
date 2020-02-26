---
title: database::db profiles
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for all Oracle profiles you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                      | Short Description                      |
----------------------------------- | -------------------------------------- |
[list](#database::db_profiles_list) | A list of dataaase profiles to define. |




### list<a name='database::db_profiles_list'>

A list of dataaase profiles to define.

The default value is: {}

This is a simple way to get started. It is easy to get started, but soon your hiera yaml become a nigtmare. Our advise is when you need to let puppet manage your Oracle profiles, to override this class and  add your own puppet implementation. This is much better maintainable
and adds more consistency.

Type: `Hash`


[Back to overview of database::db_profiles](#attributes)
