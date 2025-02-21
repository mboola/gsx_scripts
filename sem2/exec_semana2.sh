#!/bin/bash
#
# TESTS to check correct functionality of:
# install_monitoritza.sh

# Accions necessaries per a realitzar els tests
./desinstall_monitoritza.sh

# 1. Normal test
echo "Prueba 1: Ejecución del script por primera vez (se espera una instalación exitosa=archivo error vacío)..."
./install_monitoritza.sh 2> error 1> correct
echo ""
if [ ! -s error ]; then
    echo "Test 1 correcto"
else
    echo "Test 1 incorrecto"
fi
rm correct error

echo "Prueba 2: Grep para comprobar que monitoritzar está correctamente instalado"
if sudo systemctl list-units | grep -q "monitoritzar_logs.service"; then
    echo "Test 2 correcto"
else
    echo "Test 2 incorrecto"
fi

# 2. Test when the service is already installed
echo "Prueba 3: Ejecución del script nuevamente (se espera un error por servicio ya existente)..."
./install_monitoritza.sh 2> error 1> correct
echo ""
errorLink="ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.service': File exists
ln: failed to create symbolic link '/etc/systemd/system/monitoritzar_logs.timer': File exists"
if grep -Fxq "$errorLink" error; then
    echo "Test 3 correcto"
else
    echo "Test 3 incorrecto"
fi
rm correct error

# 4.
./desinstall_monitoritza.sh

if sudo systemctl list-units | grep -q "monitoritzar_logs.service"; then
    echo "Test 4 incorrecto"
else
    echo "Test 4 correcto"
fi
