#!/bin/sh

# Generate simulator argument files
echo "### Building simulator arguments ..."
perl build_sim_args.pl 50000 50999

# Start snmp simulators
echo "### Starting SNMP Simulators ..."
snmpsimd  --data-dir=./snmprec/DES-3028  --args-from-file=sim_port_50000_50999.txt 

