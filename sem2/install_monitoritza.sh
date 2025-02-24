#!/bin/bash
#
# Installs the service "monitoritzar_logs.service"

echo -e "\e[32m[LOG]Se va a activar el servicio monitoritzar_logs con su timer de 5min\e[0m" >&1
#Allocate executable
sudo cp -p monitoritzar_logs.sh /usr/local/bin/monitoritzar_logs.sh 2>&2 1>&1

#Allocate service and timer
sudo cp -p monitoritzar_logs.service /lib/systemd/system/monitoritzar_logs.service 2>&2 1>&1
sudo cp -p monitoritzar_logs.timer /lib/systemd/system/monitoritzar_logs.timer 2>&2 1>&1

#Makes soft links that point to service and timer
sudo ln -s /lib/systemd/system/monitoritzar_logs.service /etc/systemd/system/monitoritzar_logs.service 2>/dev/null 1>&1 || echo "Soft link already exists with monitoritzar_logs.service" >&2
sudo ln -s /lib/systemd/system/monitoritzar_logs.timer /etc/systemd/system/monitoritzar_logs.timer 2>/dev/null 1>&1 || echo "Soft link already exists with monitoritzar_logs.timer" >&2

sudo cp -p monitoritzar.conf /etc/monitoritzar.conf

#Reloads systemd configuration files
sudo systemctl daemon-reload

# Starts the service
sudo systemctl start monitoritzar_logs.service

# Starts the timer of the service
sudo systemctl start monitoritzar_logs.timer

echo -e "\e[32m[LOG]Estado del servicio\e[0m"
sudo systemctl status monitoritzar_logs | cat

echo -e "\e[32m[LOG]Estado del timer\e[0m"
sudo systemctl status monitoritzar_logs.timer | cat
