#!/bin/sh

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl build_sim_args.pl 50000 50001

# Start snmp simulators
echo "### Starting SNMP Simulators ..."
snmpsimd  --v2c-arch  --data-dir=./snmprec/DES-3028/public  --args-from-file=sim_port_50000_50001.txt 

