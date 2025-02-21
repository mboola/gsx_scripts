#!/bin/bash
#
# Desinstalls the service "monitoritzar_logs.service"
#!/bin/bash

#Todo error en estándard output y todo estándard output en /dev/null -> output más limpio en el joc de provas
exec >/dev/null 2>&1

sudo systemctl stop monitoritzar_logs.service
sudo systemctl disable monitoritzar_logs.service

sudo systemctl stop monitoritzar_logs.timer

sudo rm -rf /usr/local/bin/monitoritzar_logs.sh
sudo rm -rf /var/log/monitoritzar_logs.log

sudo rm /etc/monitoritzar.conf

# Create the service
sudo rm -rf /lib/systemd/system/monitoritzar_logs.service
sudo rm -rf /lib/systemd/system/monitoritzar_logs.timer

sudo rm -rf /etc/systemd/system/monitoritzar_logs.service
sudo rm -rf /etc/systemd/system/monitoritzar_logs.timer

sudo systemctl daemon-reload

echo -e "\e[32m[LOG]Estado del servicio\e[0m"
sudo systemctl status monitoritzar_logs.service

echo -e "\e[32m[LOG]Estado del timer\e[0m"
sudo systemctl status monitoritzar_logs.timer
