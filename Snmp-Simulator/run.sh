#!/bin/sh

###########################################################################
#
# Launch snmpsimd to simulate 250 SNMP devices which use port 50001~50250
# y.s.n@live.com, 2015-06-02, SNMP-Simulation
#
##########################################################################


#if [ $# -lt 1 ]; then
#	echo "Require more arguments. Please specify the host IP address.";
#	echo "Example:";
#    echo "\t./THIS-SCRIPT  172.18.190.46";
#	exit 0
#fi

LOCALIP=`ifconfig | grep 'inet' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{print $2}'`
echo "### We will use localhost IP: $LOCALIP"
#exit 0

# REMOVE the tmp directory so that we can start over again
echo "### Removing tmp directory to start over ...";
rm  -rf  tmp/

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl  build-simulator-args.pl  $LOCALIP  50001  50250

# Generate disctinct transport id based on IP-address
STARTID=`perl  gen-transport-id.pl  $LOCALIP`;
echo "### We will use id start from: $STARTID";

# Start snmp simulators
echo "### Building SNMP transport id ..."
perl  build-transport-id.pl  ./static  $STARTID  250 

# READY to invoke
echo "### Run SNMP simulators now ...";
snmpsimd  --v2c-arch  --data-dir=./tmp  --transport-id-offset=$STARTID  --args-from-file=./tmp/sim_port_50001_50250.txt

