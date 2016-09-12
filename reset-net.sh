#!/bin/bash

ifconfig xenbr0 down
brctl delbr xenbr0
sleep 5
udhcpc eth0
sleep 5
./netup
