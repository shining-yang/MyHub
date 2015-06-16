#!/bin/sh

###########################################################################
#
# Launch snmpsimd to simulate 200 SNMP devices which use port 50000~50199
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
##########################################################################


if [ $# -lt 1 ]; then
	echo "Require more arguments. Please specify the host IP address.";
	echo "Example:";
    echo "\t./THIS-SCRIPT  172.18.190.46";
	exit 0
fi

# REMOVE the tmp directory so that we can start over again
echo "### Removing tmp directory to start over ...";
rm  -rf  tmp/

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl  build-simulator-args.pl  $1  50000  50009

# Start snmp simulators
echo "### Building SNMP transport id ..."
perl  build-transport-id.pl  ./static  1000  10

# READY to invoke
echo "### Run SNMP simulators now ...";
snmpsimd  --v2c-arch  --data-dir=./tmp  --transport-id-offset=1000  --args-from-file=./tmp/sim_port_50000_50009.txt
