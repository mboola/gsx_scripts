#!/bin/bash
#
# TESTS to check correct functionality of:
# install_monitoritza.sh

# Accions necessaries per a realitzar els tests
./desinstall_monitoritza.sh

# 1. Normal test
echo "Prueba 1: Ejecución del script por primera vez (se espera una instalación exitosa=archivo error vacío)..."
./install_monitoritza.sh 2> error 1> correct
if [ ! -s error ]; then
    echo -e "\e[32mTest 1 correcto\e[0m"
else
    echo -e "\e[31mTest 1 incorrecto\e[0m"
fi
rm correct error

echo "Prueba 2: Grep para comprobar que monitoritzar está correctamente instalado"
if sudo systemctl list-units | grep -q "monitoritzar_logs.service"; then
    echo -e "\e[32mTest 2 correcto\e[0m"
else
    echo -e "\e[31mTest 2 incorrecto\e[0m"
fi

# 2. Test when the service is already installed
echo "Prueba 3: Ejecución del script nuevamente (se espera un error por servicio ya existente)..."
./install_monitoritza.sh 2> error 1> correct
echo ""
errorLink="ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.service': File exists
ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.timer': File exists"
if grep -Fxq "$errorLink" error; then
    echo -e "\e[32mTest 3 correcto\e[0m"
else
    echo -e "\e[31mTest 3 incorrecto\e[0m"
fi
rm correct error

# 4. Test when the service is uninstalled
echo "Prueba 4: Búsqueda del servicio (grep) una vez eliminado (se espera que no se encuentre)"
./desinstall_monitoritza.sh
if sudo systemctl list-units | grep -q "monitoritzar_logs.service"; then
    echo -e "\e[31mTest 4 incorrecto\e[0m"
else
    echo -e "\e[32mTest 4 correcto\e[0m"
fi
