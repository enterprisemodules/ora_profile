
The list of interfaces to use for RAC.

The value should be a comma separated strings where each string is as shown below

```
InterfaceName:SubnetAddress:InterfaceType
```

where InterfaceType can be either "1", "2", "3", "4" or "5" (1 indicates public, 2 indicates private, 3 indicates the interface is not used, 4 indicates ASM and 5 indicates ASM & Private)

The default value is: `undef`
