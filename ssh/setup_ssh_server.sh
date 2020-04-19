#!/bin/bash
#Author=Ankit Raj
#Script to setup SSH server

# generate random port number for usage as SSH port
portval=$(shuf -i 22000-22099 -n 1)
portval=22081
echo "------------------------------------------------------------"
echo -e "\tOpenSSH optimization started."
echo ""

# create a backup
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Inplace replacement in the sshd config file
sudo sed -i 's/AllowTcpForwarding yes/AllowTcpForwarding no/g' /etc/ssh/sshd_config
sudo sed -i 's/Banner /etc/issue.net /etc/issue.net/g' /etc/ssh/sshd_config

sudo sed '/Port*/d' -i /etc/ssh/sshd_config
#sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config

# new comments added
sudo printf "\nPort $portval" >>  /etc/ssh/sshd_config
sudo printf "\nGatewayPorts no" >>  /etc/ssh/sshd_config
sudo printf "\nClientAliveCountMax 3" >>  /etc/ssh/sshd_config
sudo printf "\nClientAliveInterval 25" >>  /etc/ssh/sshd_config
sudo printf "\nAllowUsers $USER" >>  /etc/ssh/sshd_config
#printf "\n PasswordAuthentication no" >>  /etc/ssh/sshd_config
sudo ufw limit ssh # limit connection to SSH port

printf "***************************************************************************
                        NOTICE TO USERS
This computer system is the private property of its owner, whether
individual, corporate or government.  It is for authorized use only.
Users (authorized or unauthorized) have no explicit or implicit
expectation of privacy. All usage is logged. ;-)
****************************************************************************
                          System admin
****************************************************************************" >>   /etc/issue.net
echo -e "\tSummary : SSH port $portval"
echo -e "\tAccess granted to user  : $USER"
echo -e "\tRestarting OpenSSH..."
sudo service ssh restart
echo "------------------------------------------------------------"

# ----------------------------------------------------------------
if [ $? -eq 0 ]
then
  echo "\t SSH server restarted."
  exit 0
else
  echo -e "\t Error restarting SSH server.\n " >&2
  echo -e "\t Check config file : /etc/ssh/sshd_config \n "
  exit 1
fi
