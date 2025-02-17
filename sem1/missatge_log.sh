#!/bin/bash
#
# Sends log and checks if message arrives

if [ ${#} -ne 2 ]; then
	echo "Error: input params!" >&2
	exit
fi

logger -p user.err "hola caracola"
logger -p user.info "hola caracola"
logger -p user.warning "hola caracola"

