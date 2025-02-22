# !/bin/bash
# 
# Installs a script to be executed with crontab

chmod +x "copia_seguretat.sh"

sudo cp -p copia_seguretat.sh /usr/local/bin/copia_seguretat.sh 2>&2 1>&1

# Add the cron job (if not already present)
echo "0 8 * * * /usr/local/bin/copia_seguretat.sh" | crontab -
