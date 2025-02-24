#!/bin/bash
#
# Installs the service "monitoritzar_logs.service"

# Allocate executable
sudo cp -p monitoritzar_logs.sh /usr/local/bin/monitoritzar_logs.sh 2>&2 1>&1

# Move service
chmod 755 monitoritzar_logs_sysv
sudo cp -p monitoritzar_logs_sysv /etc/init.d/monitoritzar_logs_sysv 2>&2 1>&1

sudo update-rc.d monitoritzar_logs_sysv defaults

# Start service
sudo service monitoritzar_logs_sysv start 

# Read service's status
sudo service monitoritzar_logs_sysv status | cat

# Stop servide
sudo service monitoritzar_logs_sysv stop

# Restart service
#sudo service monitoritzar_logs_sysv start

# Stop servide
#sudo service monitoritzar_logs_sysv stop
