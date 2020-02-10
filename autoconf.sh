#!/bin/bash
## Created by Philippe BENOIST zfx.fr
## I use it to suit my own personnal needs
## edit and check both files removelist.txt and installlist.txt if you need to install  remove other software
## couleurs : \e[1;49;32m = bold green  \e[1;31m = bold; red \e[1;95m=bold;magenta \e[0m :normal
INSTALLLIST="installlist.txt" # LISTE DES PAQUET A INSTALLER
REMOVELIST="removelist.txt" # LISTE DES PAQUETS A SUPPRIMER
SOFTDIR="$HOME/logiciels" # DOSSIER INSTALLATION POUR CERTAINS LOGICIELS
NUNU='/usr/bin/nunu' # COMMANDE POUR LANCER NUNUSTUDIO
AUTOCONFDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TMPDIR="$AUTOCONFDIR/tmp"
source $AUTOCONFDIR/func.sh

show_logo
mkdir -p $TMPDIR
echo -e "\e[1;49;33mtemp dir created in : $TMPDIR\e[0m"


while IFS= read -r line || [[ -n "$line" ]]; do
  if [ $(dpkg-query -W -f='${Status}' $line 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
      echo -e "\e[1;49;32m -> installing : \e[1;49;33m $line \e[0m";
      sudo apt install -y $line 
  fi
done < "$INSTALLLIST"
 
echo -e  "\e[1;31mRemove useless softwares (removelisttxt)?\e[0m"
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
 while IFS= read -r line || [[ -n "$line" ]]; do
    if [ $(dpkg-query -W -f='${Status}' $line 2>/dev/null | grep -c "ok installed") -eq 1 ];
    then
      echo -e "\e[1;95m -> removing : \e[1;95;33m $line \e[0m";
      sudo apt remove -y $line 
    fi
 done < "$REMOVELIST"
fi
echo -e "\e[1;49;32m-> updating APT (update)\e[0m";
sudo apt update
echo -e "\e[1;49;32m-> some cleaning APT (autoremove) \e[0m";
sudo apt-get autoremove -y
echo -e "\e[1;49;32m-> more cleaning APT (autoclean) \e[0m";
sudo apt-get autoclean
echo


echo 
echo -e "\e[1;49;32m _______________________________________________________________\e[0m"
echo -e "\e[1;49;32m          installation de divers logiciels utiles  \e[0m"
echo -e "\e[1;49;32m              (micro, arduinoIDE, nunuStudio)      \e[0m"
echo -e "\e[1;49;32m _______________________________________________________________\e[0m"
echo -e "\e[1;49;32m certains programmes seront installés dans le dossier $SOFTDIR\e[0m"
mkdir -p $SOFTDIR
echo 


install_micro

## Install NVM
echo -e  "\e[1;49;32mInstall NVM ?\e[0m"
read -p "oui= o ou y | non = n :: " -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
 install_nvm
fi

## create "ser" command to serve directory (using node http-server)
echo -e  "\e[1;49;32mCréer la commande ser (pour lancer rapidement un serveur local)?\e[0m"
read -p "oui= o ou y | non = n :: " -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
 create_ser
fi

# Atom
echo -e  "\e[1;49;32mInstall Atom ? (text editor : atom.io)\e[0m"
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
 install_atom
fi
## NunuStudio
echo -e  "\e[1;49;32mInstall NunuStudio ? \e[0m"
read -p "oui= o ou y | non = n :: " -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
 install_nunustudio
fi

## Wifi Drivers
echo -e  "\e[1;49;32mInstall rtle88xx wifi drivers ? ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_rtl8821
fi

echo -e  "\e[1;49;32mRestore Bash Profile ? ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  set_bashprofile
fi

## Arduino IDE
echo -e  "\e[1;49;32mInstall ArduinoIDE  ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_arduino
fi

## CHARLES PROXY
echo -e  "\e[1;49;32mInstall Charles-Proxy ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_charles
fi

## BOOT REPAIR
echo -e  "\e[1;49;32mInstall Boot-Repair ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_bootrepair
fi
