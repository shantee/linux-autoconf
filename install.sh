#!/bin/bash
#
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Starting maintenance"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

echo "Starting full install"
sh 1-install-softwares.sh

echo "Starting maintenance after install"
sudo apt-get install -f -y
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "################################################################"
echo "####################    T H E   E N D    #######################"
echo "################################################################"
