#!/bin/bash
#
# Sends message to logger and checks if message arrives

if [ ${#} -ne 2 ]; then
	echo "Error: Wrong params! 1: {message} 2: {INFO, WARNING, ERROR}" >&2
	exit
fi

message=$1
severity=$2

if [ "${severity}" == "INFO" ]; then
	sudo logger -p user.info ${message}
	sudo journalctl -p info | grep "${message}" >&1
elif [ "${severity}" == "WARNING" ]; then
	sudo logger -p user.warning ${message}
	sudo journalctl -p warning | grep "${message}" >&1
elif [ "${severity}" == "ERROR" ]; then
	sudo logger -p user.err ${message}
	sudo journalctl -p err | grep "${message}" >&1
else
	echo "Error: severity not inputed correctly." >&2
fi
