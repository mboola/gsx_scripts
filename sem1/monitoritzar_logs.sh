#!/bin/bash
#
# Prints the logs of a service 

for service in "${@}"; do
    cat "/var/log/"${service}
done