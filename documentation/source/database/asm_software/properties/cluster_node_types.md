The names of the nodes in the RAC cluster.

Valid values are:

- `node1:node1-vip,node2:node2-vip`                     (version >= 11 <= 12.1)
- `node1:node1-vip:HUB,node2:node2-vip:LEAF`            (version >= 12.1 Flex Cluster)
- `node1,node2`                                         (version = 12.2 Application Cluster)
- `node1:node1-vip:HUB:site1,node2:node2-vip:HUB:site2` (version = 12.2 Extended Cluster)

The default value is: `undef`
