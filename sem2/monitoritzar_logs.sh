#!/bin/bash
#
# Prints the logs of a service.

echo "funca"

for service in "${@}"; do
    sudo journalctl -u ${service} >&1
done
