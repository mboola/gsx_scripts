#!/bin/bash
#
# Prints the logs of a service.

sudo journalctl ${1} >&1
