# !/bin/bash
# 
# Installs a script to be executed with crontab

chmod +x "copia_seguretat.sh"

sudo cp -p copia_seguretat.sh /usr/local/bin/copia_seguretat.sh 2>&2 1>&1

#TODO : remove this. Create dir to test
sudo mkdir /usr/local/bin/test_timer
echo "testing" > test
sudo mv test /usr/local/bin/test_timer/test
sudo cp -p copia_seguretat.in /etc/copia_seguretat.in 2>&2 1>&1

# Add the cron job (if not already present)

echo "47 20 * * * /usr/local/bin/copia_seguretat.sh /usr/local/bin/test_timer 2> /var/log/copia_seguretat_err.log 1> /var/log/copia_seguretat_std.log" | sudo crontab -
