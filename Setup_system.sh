#!/bin/bash
#Author=Ankit Raj
#Script to install applications automatically in Ubuntu for a typical research / scientifica analysis/ calculation environment.
# and remove unnecessary applications.

echo "==========-----SYSTEM SETUP AND OPTIMIZATION SCRIPT ------=========="
echo ""
echo "Updating and upgrading"
echo ""
sudo apt  update
sudo apt upgrade -y
echo ""
echo "------------------------------------------------------------"
echo ""
echo "Removing packages..."
echo ""
#REMOVING NON-USEFUL PACKAGES

sudo apt-get remove gnome-orca -y
sudo apt-get autoremove indicator-messages -y
sudo apt-get autoremove telepathy-indicator -y
sudo apt-get autoremove deja-dup -y
sudo apt-get autoremove ubuntuone-client python-ubuntuone-control-panel -y

#fonts
sudo apt remove --purge fonts-tlwg-kinnari-ttf  fonts-tlwg-laksaman      fonts-tlwg-laksaman-ttf fonts-tlwg-sawasdee-ttf        fonts-tlwg-sawasdee fonts-guru-extra fonts-guru           -y
sudo apt-get remove --purge  bluez-audio bluez-cups bluez-gnome bluez-utils gnome-orca brltty brltty-x11 gnome-accessibility-themes gnome-mag libgnome-mag2  -y
sudo apt-get remove --purge  libbeagle1 transmission-common transmission-gtk espeak espeak-data libespeak1 libgnome-speech7 -y
sudo apt-get remove --purge  ttf-malayalam-fonts ttf-thai-tlwg ttf-unfonts-core -y
sudo apt-get remove --purge  gnome-games gnome-games-data gnome-cards-data gnome-games gnome-games-data gnome-cards-data thunderbird -y

echo ""
echo "------------------------------------------------------------"
echo ""
echo "Installing packages..."
echo ""
#START INSTALLATION OF NECESSARY PACKAGES

sudo apt install make cmake htop -y
sudo apt-get install --dry-run bum openssh-server  build-essential  libfftw3-3 libfftw3-bin  libfftw3-dbg libfftw3-dev libfftw3-doc libfftw3-double3  libfftw3-long3  libfftw3-quad3  libfftw3-single3
# sudo nano  /etc/ssh/sshd_config
sudo apt install -f bum openssh-server build-essential filezilla  msttcorefonts faac faad -y
sudo apt install -f liblapack-dev liblapack-doc  liblapack-doc-man  liblapack-pic  liblapack-test  liblapack3  liblapack3gf  liblapacke  liblapacke-dev  -y
sudo apt install -f libatlas-base-dev  libatlas-dev  libatlas-doc  libatlas-test libatlas3-base -y
sudo apt install -f  libfftw3-3 libfftw3-bin  libfftw3-dbg libfftw3-dev libfftw3-doc libfftw3-double3  libfftw3-long3  libfftw3-quad3  libfftw3-single3  -y
#sudo apt install liblapack-dev liblapack-doc  liblapack-doc-man  liblapack-pic  liblapack-test  liblapack3  liblapack3gf  liblapacke  liblapacke-dev
sudo apt install -f synaptic dconf-tools gksu gdebi -y
sudo apt install -f gfortran pigz mdadm  -y
sudo apt install -f stress tmux -y
sudo apt install -f compizconfig-settings-manager -y
sudo apt install -f libatlas-base-dev  libatlas-dev  libatlas-doc  libatlas-test libatlas3-base -y
sudo apt install -f python-tk x11vnc  -y # x11vnc installed here
sudo apt install -f unity-tweak-tool -y
sudo apt install -f default-jre -y
sudo apt install -f  avogadro-data  avogadro-dbg    libavogadro-dev    libavogadro1    python-avogadro   -y
sudo apt install -f jmol  jmol-applet   libjmol-java   libjmol-java-doc   -y
#gksudo bum

echo ""
echo "------------------------------------------------------------"
echo ""
echo "Cleaning up..."
echo ""
sudo apt-get autoclean
sudo apt-get autoremove

echo ""
#SYSTEM OPTIMIZATION
echo ""
echo "------------------------------------------------------------"
echo ""
echo "SYSTEM OPTIMIZATION SECTION"
echo "lightdm -- Guest user removed."
sudo sh -c "echo 'allow-guest=false' >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf"

echo ""
echo "Swappiness changed to 10"
printf "\n vm.swappiness = 10" >>  /etc/sysctl.conf
#echo "Swappiness changed to : " cat /proc/sys/vm/swappiness   # will change only after reboot
echo ""
echo "------------------------------------------------------------"
echo "SSH optimization started."
echo ""
# SSH optimimization
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup #backup
sudo sed -i 's/AllowTcpForwarding yes/AllowTcpForwarding no/g' /etc/ssh/sshd_config
#sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config
sudo sed -i 's/Port*/Port 22050/g' /etc/ssh/sshd_config # does not work (check to verify)
sudo printf "\n GatewayPorts no" >>  /etc/ssh/sshd_config
sudo printf "\n ClientAliveCountMax 3" >>  /etc/ssh/sshd_config
sudo printf "\n ClientAliveInterval 30" >>  /etc/ssh/sshd_config
sudo printf "\n AllowUsers vayu" >>  /etc/ssh/sshd_config
#printf "\n PasswordAuthentication no" >>  /etc/ssh/sshd_config
sudo ufw limit ssh # limit connection to SSH port
sudo sed -i 's/#Banner /etc/issue.net/Banner /etc/issue.net/g' /etc/ssh/sshd_config

printf "***************************************************************************
                            NOTICE TO USERS


This computer system is the private property of its owner, whether
individual, corporate or government.  It is for authorized use only.
Users (authorized or unauthorized) have no explicit or implicit
expectation of privacy.

  Unauthorized or improper use
of this system may result in civil and criminal penalties and
administrative or disciplinary action, as appropriate. By continuing to
use this system you indicate your awareness of and consent to these terms
and conditions of use. LOG OFF IMMEDIATELY if you do not agree to the
conditions stated in this warning otherwise you will be destroyed !

****************************************************************************
                           Gandalf, the white           
****************************************************************************" >>   /etc/issue.net
sudo service ssh restart
echo ""
echo "------------------------------------------------------------"
echo ""
echo "File system. Removing Public, Music and Templates folder."
sudo rm -rf ~/Public*
sudo rm -rf ~/Music
sudo rm -rf ~/Templ*

#sudo rm -rf ~/Pictu*
echo ""
echo "------------------------------------------------------------"
echo "done"
echo ""
echo "-----------------------SYSTEM INFO--------------------------"
echo ""

echo "CPU **********************************************************"
echo "__________________________________"
lscpu
echo "__________________________________"
echo "MEMORY **********************************************************"
echo "__________________________________"
sudo lshw -short -C memory

echo "__________________________________"
echo "STORAGE **********************************************************"
echo "__________________________________"
df  -h
echo ""
#echo "__________________________________"
sudo update-pciids
#echo "PCI DEVICES  *********************"
#lspci -v | less
echo "__________________________________"
echo "NETWORK **********************************************************"
echo "__________________________________"
ifconfig
#selecting ethernet from available connections
echo ""
con=$(ls /sys/class/net)
set -- $con
echo $1
#finish here !
sudo  ethtool $1 | grep -i speed
echo ""
echo "-----------LISTENING PORTS-----------------"
echo ""
netstat -atn
echo ""
echo "=============================================================="
