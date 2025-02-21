#!/bin/bash
#
# Desinstalls the service "monitoritzar_logs.service"

sudo systemctl stop monitoritzar_logs.service
sudo systemctl disable monitoritzar_logs.service

sudo systemctl stop monitoritzar_logs.timer

sudo rm -rf /usr/local/bin/monitoritzar_logs.sh

# Create the service
sudo rm -rf /lib/systemd/system/monitoritzar_logs.service
sudo rm -rf /lib/systemd/system/monitoritzar_logs.timer

sudo rm -rf /etc/systemd/system/monitoritzar_logs.service
sudo rm -rf /etc/systemd/system/monitoritzar_logs.timer

sudo systemctl daemon-reload

echo "Estado del servicio"
sudo systemctl status monitoritzar_logs.service
echo "Estado del timer"
sudo systemctl status monitoritzar_logs.timer
