#!/bin/bash
## Created by Philippe BENOIST zfx.fr
## I use it to suit my own personnal needs
## edit and check both files removelist.txt and installlist.txt if you need to install  remove other software
## couleurs : \e[1;49;32m = bold green  \e[1;31m = bold; red \e[1;95m=bold;magenta \e[0m :normal
TMPDIR="$HOME/autoconftmp"
INSTALLLIST="installlist.txt" # LISTE DES PAQUET A INSTALLER
REMOVELIST="removelist.txt" # LISTE DES PAQUETS A SUPPRIMER
SOFTDIR="$HOME/logiciels" # DOSSIER INSTALLATION POUR CERTAINS LOGICIELS
NUNU='/usr/bin/nunu' # COMMANDE POUR LANCER NUNUSTUDIO
source $(dirname "$0")/func.sh

show_logo
mkdir -p $TMPDIR
echo -e "\e[1;49;33mtemp dir created in : $TMPDIR\e[0m"
echo -e "\e[95mYou need to enter your sudo password to install pacakges\e[0m"
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

while IFS= read -r line || [[ -n "$line" ]]; do
  if [ $(dpkg-query -W -f='${Status}' $line 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
      echo -e "\e[1;49;32m -> installing : \e[1;49;33m $line \e[0m";
      sudo apt install -y $line 
  fi
done < "$INSTALLLIST"
 
echo -e  "\e[1;31mProcéder à la désinstallation des logiciels inutiles ?\e[0m"
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
apt update
echo -e "\e[1;49;32m-> some cleaning APT (autoremove) \e[0m";
sudo apt-get autoremove -y
echo -e "\e[1;49;32m-> more cleaning APT (autoclean) \e[0m";
sudo apt-get autoclean
echo
## Install NVM
echo -e  "\e[1;49;32m++++++++++++ Install NVM +++++++++++++++++\e[0m"
install_nvm

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
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  echo -e "\e[1mInstalling Atom...\e[0m"
  wget -O $TMPDIR/atomdeb https://atom.io/download/deb  -q --show-progress --progress=bar:force 2>&1
  dpkg -i $TMPDIR/atomdeb  
fi
echo 
echo -e "\e[1;49;32m _______________________________________________________________\e[0m"
echo -e "\e[1;49;32m          installation de divers logiciels utiles  \e[0m"
echo -e "\e[1;49;32m              (micro, arduinoIDE, nunuStudio)      \e[0m"
echo -e "\e[1;49;32m _______________________________________________________________\e[0m"
echo -e "\e[1;49;32m certains programmes seront installés dans le dossier $SOFTDIR\e[0m"
echo -e "\e[1;49;32m Utiliser ce dossier ? \e[0m"
read -p "oui= o ou y | non = n (dans le doute tapez o) ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[nN]$ ]]
then
while read -ep "Entrez le chemin du dossier: " USERSOFTDIR; do
    if [ -d "${USERSOFTDIR}" ]; then
         echo -e "\e[95m${USERSOFTDIR} existe déjà. Entrez un autre chemin\e[0m"
         echo
    else
        mkdir -p "${USERSOFTDIR}"
        userinstall_nunustudio
        userinstall_arduino
    break
    fi 
done
else  
mkdir -p $SOFTDIR
fi
install_micro
echo -e "\e[1m -> Installing Nunustudio\e[0m"
install_nunustudio

echo -e "\e[1m-> Installing ARDUINO IDE\e[0m"
install_arduino


echo -e  "\e[1;49;32mInstaller Charles-Proxy ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_charles
fi

echo -e  "\e[1;49;32mInstaller Boot-Repair ?\e[0m"
echo
read -p "oui= o ou y | non = n ::" -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  install_bootrepair
fi
