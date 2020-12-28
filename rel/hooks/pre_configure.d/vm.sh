#!/usr/bin/env bash
# hooks/pre_configure.d/vm.sh

SERVER_IP=`ip -4 address show | grep inet | grep -v 127.0.0 | awk '{print $2}' | cut -d'/' -f1 | head -n1`
export SERVER_IP
