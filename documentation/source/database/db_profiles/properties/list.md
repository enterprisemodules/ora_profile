A list of database profiles to define.

You must specify a Hash of [ora_profile](/docs/ora_config/ora_profile.html)

The default value is: {}

This is a simple way to get started. It is easy to get started, but soon your hiera yaml become a nigtmare. Our advise is when you need to let puppet manage your Oracle profiles, to override this class and  add your own puppet implementation. This is much better maintainable
and adds more consistency.
