#!/bin/sh

####################################################################
#
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
####################################################################


# REMOVE the tmp directory so that we can start over again
echo "### Removing tmp directory to start over ...";
rm  -rf  tmp/

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl  build-simulator-args.pl  172.18.190.46  50000  50499

# Start snmp simulators
echo "### Building SNMP transport id ..."
perl  build-transport-id.pl  ./static  1000  500

# READY to invoke
echo "### Run SNMP simulators now ...";
snmpsimd  --v2c-arch  --data-dir=./tmp  --transport-id-offset=1000  --args-from-file=./tmp/sim_port_50000_50499.txt
