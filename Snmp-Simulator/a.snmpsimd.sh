#!/bin/sh

# REMOVE the tmp directory so that we can start over again
echo "### Removing tmp directory to start over ...";
rm -rf tmp/

# Generate simulator argument files
echo "\n### Building simulator arguments ..."
perl build-simulator-args.pl 50000 50002

# Start snmp simulators
echo "\n### Building SNMP transport id ..."
perl build-transport-id.pl ./static/DES-3028 1000 4

# READY to invoke
echo "\n### Run SNMP simulators now ...\n";
snmpsimd  --v2c-arch  --data-dir=./tmp  --transport-id-offset=1000  --args-from-file=./tmp/sim_port_50000_50002.txt 
