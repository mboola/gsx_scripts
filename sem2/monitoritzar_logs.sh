#!/bin/bash
#
# Prints the logs of a service.

sudo journalctl -p ${1} >&1
