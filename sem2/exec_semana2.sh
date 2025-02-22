#!/bin/bash
# TESTS to check correct functionality of: install_monitoritza.sh

# Acciones necesarias previas
./uninstall_monitoritza.sh
./uninstall_monitoritza_sysv.sh

# Función para ejecutar pruebas
run_test() {
  desc=$1; cmd=$2; success=$3; fail=$4
  echo "$desc"
  eval "$cmd" && echo -e "\e[32m$success\e[0m" || echo -e "\e[31m$fail\e[0m"
}

# Tests install_monitoritza.sh
# 1. Normal test
run_test "Prueba 1 (systemd): Instalación inicial (error vacío esperado)" \
  "./install_monitoritza.sh 2> error 1> correct && [ ! -s error ]" \
  "\e[32mTest 1 correcto\e[0m" "\e[31mTest 1 incorrecto\e[0m"
rm -f correct error

run_test "Prueba 2 (systemd): Verificación de instalación de monitoritzar" \
  "sudo systemctl list-unit-files | grep -q monitoritzar_logs.service" \
  "\e[32mTest 2 correcto\e[0m" "\e[31mTest 2 incorrecto\e[0m"

# 3. Test when the service is already installed
errorLink="ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.service': File exists
ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.timer': File exists"

run_test "Prueba 3 (systemd): Instalación duplicada (se espera error)" \
  "./install_monitoritza.sh 2> error 1> correct && grep -Fxq \"$errorLink\" error" \
  "\e[32mTest 3 correcto\e[0m" "\e[31mTest 3 incorrecto\e[0m"
rm -f correct error

# 4. Test when the service is uninstalled
run_test "Prueba 4 (systemd): Eliminación y verificación de servicio" \
  "./uninstall_monitoritza.sh && ! sudo systemctl list-units | grep -q monitoritzar_logs.service" \
  "\e[31mTest 4 incorrecto\e[0m" "\e[32mTest 4 correcto\e[0m"

# Tests install_monitoritza_sysv.sh
# 1. Normal test
run_test "Prueba 5 (SysV): Instalación inicial (error vacío esperado)" \
  "./install_monitoritza_sysv.sh 2> error 1> correct && [ ! -s error ]" \
  "\e[32mTest 1 correcto\e[0m" "\e[31mTest 1 incorrecto\e[0m"
rm -f correct error

run_test "Prueba 6 (SysV): Verificación de instalación" \
  "sudo service --status-all | grep -q monitoritzar_logs_sys" \
  "\e[32mTest 2 correcto\e[0m" "\e[31mTest 2 incorrecto\e[0m"

# 4. Test when the service is uninstalled
run_test "Prueba 7 (SysV): Eliminación y verificación" \
  "./uninstall_monitoritza.sh && ! sudo service --status-all | grep -q monitoritzar_logs_sys" \
  "\e[31mTest 3 incorrecto\e[0m" "\e[32mTest 3 correcto\e[0m"


# Tests install_cron.sh
# 1. Check that petition to cron gets added correctly
./install_cron.sh

if crontab -l | tail -1 | grep -Fxq "0 8 * * * /usr/local/bin/copia_seguretat.sh"; then
  echo -e "\e[32mCorrecto\e[0m"
else
  echo -e "\e[31mError\e[0m"
fi
    
