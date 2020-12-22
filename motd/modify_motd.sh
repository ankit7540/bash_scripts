#!/bin/sh

# Change the MOTD in Ubuntu
# ---------------------------------------------
echo -e "\tChanging MOTD"
sudo chmod -x /etc/update-motd.d/10-help-text;
sudo chmod -x /etc/update-motd.d/50-motd-news;
sudo chmod -x /etc/update-motd.d/80-esm;
sudo chmod -x /etc/update-motd.d/80-livepatch;

sudo chmod -x /etc/update-motd.d/91-release-upgrade;
sudo chmod -x /etc/update-motd.d/92-unattended-upgrades;
sudo chmod -x /etc/update-motd.d/95-hwe-eol;

# ---------------------------------------------

sudo cat header_template.sh > /etc/update-motd.d/00-header;

if [ $? -eq 0 ]
then
  echo "\t Error in MOTD header change."
  exit 0
else
  echo "\t MOTD modified. " >&2
  exit 1
fi

# ---------------------------------------------
