#!/bin/sh

# Retrieve or specify localhost IP
LOCALIP=172.18.190.25


# REMOVE the tmp directory so that we can start over again
echo "### Removing tmp directory to start over ...";
rm  -rf  tmp

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl  build-simulator-args.pl  $LOCALIP  50000  50255

# Start snmp simulators
echo "### Building SNMP transport id ..."
perl  build-transport-id.pl  static  1000  256

# READY to invoke
echo "### Run SNMP simulators now ...";
snmpsimd  --v2c-arch  --data-dir=tmp  --transport-id-offset=1000  --args-from-file=tmp/sim_port_50000_50255.txt  &
