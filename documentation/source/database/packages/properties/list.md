The required packages for a succesfull Oracle installation.

You must specify a Hash of [packages](https://puppet.com/docs/puppet/6/types/package.html)


The default packages are:

```yaml
ora_profile::database::packages::list:
- binutils.x86_64
- compat-libcap1.x86_64
- compat-libstdc++-33.i686
- compat-libstdc++-33.x86_64
- gcc.x86_64
- gcc-c++.x86_64
- glibc.i686
- glibc.x86_64
- glibc-devel.i686
- glibc-devel.x86_64
- ksh
- libaio.i686
- libaio.x86_64
- libaio-devel.i686
- libaio-devel.x86_64
- libgcc.i686
- libgcc.x86_64
- libstdc++.i686
- libstdc++.x86_64
- libstdc++-devel.i686
- libstdc++-devel.x86_64
- libXi.i686
- libXi.x86_64
- libXtst.i686
- libXtst.x86_64
- make.x86_64
- sysstat.x86_64
```