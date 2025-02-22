#!/bin/bash
#
# Installs the service "monitoritzar_logs.service"

#TODO : remove this. Create dir to test
sudo mkdir /usr/local/bin/test_timer
echo "testing" > test
sudo mv test /usr/local/bin/test_timer/test

sudo cp -p copia_seguretat.conf /etc/copia_seguretat.conf

#Allocate executable
sudo cp -p copia_seguretat.sh /usr/local/bin/copia_seguretat.sh 2>&2 1>&1

#Allocate service and timer
sudo cp -p copia_seguretat.service /lib/systemd/system/copia_seguretat.service 2>&2 1>&1
sudo cp -p copia_seguretat.timer /lib/systemd/system/copia_seguretat.timer 2>&2 1>&1

#Makes soft links that point to service and timer
sudo ln -s /lib/systemd/system/copia_seguretat.service /etc/systemd/system/copia_seguretat.service 2>&2 1>&1
sudo ln -s /lib/systemd/system/copia_seguretat.timer /etc/systemd/system/copia_seguretat.timer 2>&2 1>&1

sudo systemctl daemon-reload

sudo systemctl start copia_seguretat.timer
