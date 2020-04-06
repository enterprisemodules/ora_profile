The required packages for a succesfull Oracle client installation.

The defaults are:

```yaml
ora_profile::client::packages::list:
  psmisc:
    ensure: present
  unzip:
    ensure: present
  binutils.x86_64:
    ensure: present
  compat-libcap1.x86_64:
    ensure: present
  compat-libstdc++-33.i686:
    ensure: present
  compat-libstdc++-33.x86_64:
    ensure: present
  gcc.x86_64:
    ensure: present
  gcc-c++.x86_64:
    ensure: present
  glibc.i686:
    ensure: present
  glibc.x86_64:
    ensure: present
  glibc-devel.i686:
    ensure: present
  glibc-devel.x86_64:
    ensure: present
  ksh:
    ensure: present
  libaio.i686:
    ensure: present
  libaio.x86_64:
    ensure: present
  libaio-devel.i686:
    ensure: present
  libaio-devel.x86_64:
    ensure: present
  libgcc.i686:
    ensure: present
  libgcc.x86_64:
    ensure: present
  libstdc++.i686:
    ensure: present
  libstdc++.x86_64:
    ensure: present
  libstdc++-devel.i686:
    ensure: present
  libstdc++-devel.x86_64:
    ensure: present
  libXi.i686:
    ensure: present
  libXi.x86_64:
    ensure: present
  libXtst.i686:
    ensure: present
  libXtst.x86_64:
    ensure: present
  make.x86_64:
    ensure: present
  sysstat.x86_64:
    ensure: present
```