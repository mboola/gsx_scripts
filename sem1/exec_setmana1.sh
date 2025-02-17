#!/bin/bash
#
# Runs tests to check correct functionality of:
# comprovar_paquet.sh, monitoritzar_logs.sh, missatge_log and copia_seguretat.sh

# Accions necessaries per a realitzar els tests
sudo apt-get install rsyslog
sudo apt-get remove vim

# Tests comprovar_paquet.sh
# 1.Test sense parametres
./comprovar_paquet.sh 2> error 1> correcte
echo ""
grep -Fxq "Error: input packages!" error && echo "Test 1.1 correct" || echo "Test 1.1 incorrect"
rm correcte error

# 2.Test amb paquet ja instalat
./comprovar_paquet.sh rsyslog 2> error 1> correcte
echo ""
grep -Fxq "Error: packet 'rsyslog' already installed!" error && echo "Test 1.2 correct" || echo "Test 1.2 incorrect"
rm correcte error

# 3.Test amb paquet no instalat
./comprovar_paquet.sh vim 2> error 1> correcte
echo ""
grep -Fxq "Correcte: packet 'vim' has been installed." correcte && echo "Test 1.3 correct" || echo "Test 1.3 incorrect"
rm correcte error

# 4.Test amb paquet no existent
./comprovar_paquet.sh monkgoat 2> error 1> correcte
echo ""
grep -Fxq "Error: packet 'monkgoat' does not exist." error && echo "Test 1.4 correct" || echo "Test 1.4 incorrect"
rm correcte error

sudo apt-get remove vim

# 5.Test amb diversos paquets
./comprovar_paquet.sh rsyslog vim 2> error 1> correcte
echo ""
grep -Fxq "Correcte: packet 'vim' has been installed." correcte && echo "Test 1.5.1 correct" || echo "Test 1.5.1 incorrect"
grep -Fxq "Error: packet 'rsyslog' already installed!" error && echo "Test 1.5.2 correct" || echo "Test 1.5.2 incorrect"
rm correcte error

# Tests monitoritzar_logs.sh i missatge_log
# 1.Test sense parametres
./monitoritzar_logs.sh 2> error 1> correcte
rm correcte error

# 2.Test amb parametres
./monitoritzar_logs.sh cron 2> error 1> correcte
[ "$(cat correcte | wc -l)" -ne 0 ] && echo "Test 2.1 correct" || echo "Test 2.1 incorrect"
rm correcte error

# 3.Test missatge logs sense parametres
./missatge_log.sh 2> error 1> correcte
grep -Fxq "Error: Wrong params! 1: {message} 2: {INFO, WARNING, ERROR}" error && echo "Test 2.2 correct" || echo "Test 2.2 incorrect"
rm correcte error

# 4.Test missatge logs parametres incorrectes
./missatge_log.sh "hola" 2> error 1> correcte
grep -Fxq "Error: Wrong params! 1: {message} 2: {INFO, WARNING, ERROR}" error && echo "Test 2.3 correct" || echo "Test 2.3 incorrect"
rm correcte error

# 5.Test missatge logs parametres correctes
./missatge_log.sh "hola moncusi" "INFO" 2> error 1> correcte
grep -Fq "hola moncusi" correcte && echo "Test 2.4 correct" || echo "Test 2.4 incorrect"
rm correcte error
