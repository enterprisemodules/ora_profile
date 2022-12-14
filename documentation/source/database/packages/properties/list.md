The required packages for a succesfull Oracle installation.

You must specify a Hash of [packages](https://puppet.com/docs/puppet/6/types/package.html)

The default packages for a database installation are dependant on the version of your OS.
For a Grid installation additional packages might be required and are specified in the `ora_profile::database::asm_packages::list` Hash for your OS version.

For RedHat 7 / OracleLinux 7 the packages are:

```yaml
ora_profile::database::packages::list:
- bc
- binutils
- compat-libcap1
- compat-libstdc++-33.x86_64
- e2fsprogs.x86_64
- e2fsprogs-libs.x86_64
- glibc.x86_64
- glibc-devel.x86_64
- ksh
- libaio.x86_64
- libaio-devel.x86_64
- libX11.x86_64
- libXau.x86_64
- libXi.x86_64
- libXtst.x86_64
- libgcc.x86_64
- libstdc++.x86_64
- libstdc++-devel.x86_64
- libxcb.x86_64
- libXrender.x86_64
- libXrender-devel.x86_64
- make.x86_64
- policycoreutils.x86_64
- policycoreutils-python.x86_64
- smartmontools.x86_64
- sysstat.x86_64
```

For RedHat 8 / OracleLinux 8 the packages are:

```yaml
ora_profile::database::packages::list:
- binutils.x86_64
- glibc.x86_64
- glibc-devel.x86_64
- ksh
- libaio.x86_64
- libaio-devel.x86_64
- libgcc.x86_64
- libstdc++.x86_64
- libstdc++-devel.x86_64
- libXi.x86_64
- libXtst.x86_64
- make.x86_64
- sysstat.x86_64
- unzip.x86_64
- psmisc
- libnsl
- libnsl2
```