# !/bin/bash
#
# Desinstalls the service "monitoritzar_logs.service"

#Todo error en estándard output y todo estándard output en /dev/null -> output más limpio en el joc de provas
exec >/dev/null 2>&1

# Stop servide
sudo service monitoritzar_logs_sysv stop

sudo rm -rf /etc/init.d/monitoritzar_logs_sysv

sudo rm -rf /usr/local/bin/monitoritzar_logs.sh

sudo update-rc.d monitoritzar_logs_sysv defaults
