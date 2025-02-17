#!/bin/bash
#
# Recieves packets and checks if they are installed.
# If they aren't, they get installed.

# First we check if there are any parameters
if [ ${#} -eq 0 ]; then
	echo "Error: input packages!" >&2
	exit
fi

# First we should check if 'apt' is in the latest version
# TODO : check if last version
#sudo apt update

# For each packet, check if it needs to be installed
for package in "${@}"; do
	result=$(dpkg -l | grep " ${package} ")
	if [ -z "${result}" ]; then
		echo "Error: packet '"${package}"' does not exist." >&2
	else
		result=$(echo ${result} | cut -c1-2)
		if [ "${result}" = "ii" ]; then
			echo "Error: packet '"${package}"' already installed!" >&2
		else
			echo "Package "${package}" not installed. Installing it." >&1
			sudo apt-get install ${package}
			if [ $? -ne 0 ]; then
				echo "Error: packet could not be installed!" >&2
			else
				echo "Correcte: packet '"${package}"' has been installed." >&1
			fi
		fi
	fi
done
