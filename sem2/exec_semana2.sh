#!/bin/bash
#
# TESTS to check correct functionality of: install_monitoritza.sh

# Acciones necesarias previas
./uninstall_monitoritza.sh
./uninstall_monitoritza_sysv.sh
./uninstall_timer.sh

# Tests install_monitoritza.sh
# 1. Normal test
echo "Prueba 1 (systemd): Instalación inicial (se espera error file vacío)"
./install_monitoritza.sh 2> error 1> correct && [ ! -s error ] && echo -e "\e[32mTest 1 correcto\e[0m" || echo -e "\e[31mTest1 incorrecto\e[0m"
rm -f correct error

echo "Prueba 2 (systemd): Verificación de instalación de monitoritza (grep)"
sudo systemctl list-unit-files | grep -q monitoritzar_logs.service && echo -e "\e[32mTest 2 correcto\e[0m" || echo -e "\e[31mTest 2 incorrecto\e[0m"

# 3. Test when the service is already installed
errorLink="Soft link already exists with monitoritzar_logs.service
Soft link already exists with monitoritzar_logs.timer"

echo "Prueba 3 (systemd): Instalación duplicada (se espera info en error file)"
./install_monitoritza.sh 2> error 1> correct && grep -Fxq "${errorLink}" error && echo -e "\e[32mTest 3 correcto\e[0m" || echo -e "\e[31mTest 3 incorrecto\e[0m"
rm -f correct error

# 4. Test when the service is uninstalled
echo "Prueba 4 (systemd): Eliminación y verificación de servicio (!grep)"
./uninstall_monitoritza.sh && ! sudo systemctl list-units | grep -q monitoritzar_logs.service && echo -e "\e[31mTest 4 incorrecto\e[0m" || echo -e "\e[32mTest 4 correcto\e[0m"

# Tests install_monitoritza_sysv.sh
# 5. Normal test
echo "Prueba 5 (SysV): Instalación inicial (se espera que el archivo error esté vacío)"
./install_monitoritza_sysv.sh 2> error 1> correct && [ ! -s error ] && echo -e "\e[32mTest 5 correcto\e[0m" || echo -e "\e[31mTest 5 incorrecto\e[0m"
rm -f correct error

# 6.  
echo "Prueba 6 (SysV): Verificación de instalación (se espera que el archivo log contenga info)"
sudo service --status-all | grep -q monitoritzar_logs_sys && echo -e "\e[32mTest 6 correcto\e[0m" || echo -e "\e[31mTest 6 incorrecto\e[0m"

# 7. Uninstall service
echo "Prueba 7 (SysV): Eliminación y verificación (!grep)"
./uninstall_monitoritza.sh && ! sudo service --status-all | grep -q monitoritzar_logs_sys && echo -e "\e[31mTest 7 incorrecto\e[0m" || echo -e "\e[32mTest 7 correcto\e[0m"

# Tests install_cron.sh and install_timer.sh
# 8. Check that petition to cron is added correctly
echo "Prueba 8 (crontab): Creación y verificación"
./install_cron.sh
cronline="0 8 * * * /usr/local/bin/copia_seguretat.sh /usr/local/bin/test_timer 2> /var/log/copia_seguretat_err.log 1> /var/log/copia_seguretat_std.log"
sudo crontab -l | tail -1 | grep -Fxq "${cronline}" && echo -e "\e[32mTest 8 correcto\e[0m" || echo -e "\e[31mTest 8 incorrecto\e[0m"

# 9. Check manually that backup works OK
# Note that copia_seguretat.timer is triggered each day at 22h, but here we check it manually to test it
echo "Prueba 9 (timer): Creación y verificación (grep)"
./install_timer.sh && sudo systemctl list-units | grep -q copia_seguretat.timer && echo -e "\e[32mTest 9 correcto\e[0m" || echo -e "\e[31mTest 9 incorrecto\e[0m"

sudo systemctl start copia_seguretat.service

# 10 y 11. Log and error file are the same in both services (cron and timer). This way we can check them easily
echo "Prueba 10: Comprobación de arhivo log (se espera que contenga info)"
[ -s /var/log/copia_seguretat_std.log ] && echo -e "\e[32mTest 10 correcto\e[0m" || echo -e "\e[31mTest 10 incorrecto\e[0m"

echo "Prueba 11 (crontab): Comprobación archivo error (se espera que esté vacío)"
[ -s /var/log/copia_seguretat_err.log ] && echo -e "\e[32mTest 11 correcto\e[0m" || echo -e "\e[31mTest 11 incorrecto\e[0m"
