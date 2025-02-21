#!/bin/bash
#
# Prints the logs of a service.

sudo journalctl ${service} >&1

