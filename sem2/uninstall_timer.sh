#!/bin/bash
#
# Desinstalls the timer "copia_seguretat.timer"
#!/bin/bash

#Todo error en estándard output y todo estándard output en /dev/null -> output más limpio en el joc de provas
exec >/dev/null 2>&1

sudo systemctl stop copia_seguretat.service
sudo systemctl stop copia_seguretat.timer

sudo rm -rf /usr/local/bin/test_timer

sudo rm -rf /var/log/copia_seguretat_std.log
sudo rm -rf /var/log/copia_seguretat_err.log

sudo rm -rf /usr/local/bin/copia_seguretat.sh

sudo rm -rf /etc/systemd/system/copia_seguretat.service
sudo rm -rf /etc/systemd/system/copia_seguretat.timer

sudo rm -rf /lib/systemd/system/copia_seguretat.service
sudo rm -rf /lib/systemd/system/copia_seguretat.timer

sudo systemctl daemon-reload

echo -e "\e[32m[LOG]Estado del servicio\e[0m"
sudo systemctl status copia_seguretat.service

echo -e "\e[32m[LOG]Estado del timer\e[0m"
sudo systemctl status copia_seguretat.timer

sudo rm -rf /usr/local/bin/*.tgz
