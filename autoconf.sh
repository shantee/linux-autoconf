#!/bin/bash
# Created by Philippe BENOIST zfx.fr
# I use it to suit my own personnal needs
# edit and check both files removelist.txt and installlist.txt if you need to install / remove other software

# couleurs : \e[1;49;32m = bold green  \e[1;31m = bold; red \e[1;95m=bold;magenta \e[0m :normal
TMPDIR="$HOME/autoconftmp"
INSTALLLIST="installlist.txt" # LISTE DES PAQUET A INSTALLER
REMOVELIST="removelist.txt" # LISTE DES PAQUETS A SUPPRIMER
SOFTDIR="$HOME/logiciels" # DOSSIER INSTALLATION POUR CERTAINS LOGICIELS
NUNU='/usr/bin/nunu' # COMMANDE POUR LANCER NUNUSTUDIO
## misc functions 
show_logo(){
clear
echo -e "\e[1;49;32m ____________________________________________________________\e[0m"
echo -e "\e[1;49;32m                 __ _                     \e[0m"
echo -e "\e[1;49;32m                / /(*)_ __  _   ___  __   \e[0m"
echo -e "\e[1;49;32m               / / | | '_ \| | | \ \/ /   \e[0m"
echo -e "\e[1;49;32m              / /__| | | | | |_|  X  X    \e[0m"
echo -e "\e[1;49;32m              \____/_|_| |_|\__,_/_/\_\   \e[0m"
echo -e "\e[1;49;32m   _______       _____      _________           ________ \e[0m"
echo -e "\e[1;49;32m   ___    |___  ___  /________  ____/______________  __/ \e[0m"
echo -e "\e[1;49;32m   __  /| |  / / /  __/  __ \  /   _  __ \_  __ \_  /_   \e[0m"
echo -e "\e[1;49;32m   _  ___ / /_/ // /_ / /_/ / /___ / /_/ /  / / /  __/   \e[0m"
echo -e "\e[1;49;32m   /_/  |_\__,_/ \__/ \____/\____/ \____//_/ /_//_/      \e[0m"
echo -e "\e[1;49;32m    auto install basic softwares, libraries & config     \e[0m"
echo -e "\e[1;49;32m ____________________________________________________________\e[0m"
echo 
}
## fonctions installations logiciels ##########
install_nunustudio(){
  cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  git clone https://github.com/tentone/nunuStudio --progress
  echo -e "\e[102mCreating command nunu (/usr/bin/nunu)\e[0m"
  NUNU='/usr/bin/nunu'
  echo "#!/bin/bash">>$NUNU
  echo "cd ~/logiciels/nunuStudio">>$NUNU
  echo "npm start & ">>$NUNU
  echo "echo ''">>$NUNU
  echo "echo '\e[102m+++++++++ au boulot ++++++++++++\e[0m'">>$NUNU
  echo "cd ~/">>$NUNU
  echo "echo ''">>$NUNU
  echo "cd ~/">>$NUNU
  chmod +x /usr/bin/nunu
}
install_arduino(){
  cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ
}
install_charles(){
echo -e "\e[1mInstalling Charles-Proxy\e[0m"
wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
apt update
apt install charles-proxy
}
install_bootrepair(){
echo -e "\e[1mInstalling Boot-Repair\e[0m"
add-apt-repository -y ppa:yannubuntu/boot-repair
apt-get -y update
apt-get install -y boot-repair
}

install_micro(){
  echo ""
  echo -e " \e[1mInstalling micro (terminal text editor)\e[0m"
  wget -O "$TMPDIR"/mic https://getmic.ro && bash "$TMPDIR"/mic
  mv "$TMPDIR"/micro /usr/bin/micro
}

## installation dans USERSOFTDIR ####################
userinstall_nunustudio(){
  cd "$USERSOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  git clone https://github.com/tentone/nunuStudio --progress
  echo -e "\e[102mCreating command nunu (/usr/bin/nunu)\e[0m"
  NUNU='/usr/bin/nunu'
  echo "#!/bin/bash">>$NUNU
  echo "cd ~/logiciels/nunuStudio">>$NUNU
  echo "npm start & ">>$NUNU
  echo "echo ''">>$NUNU
  echo "echo '\e[102m+++++++++++ au boulot ++++++++++++\e[0m'">>$NUNU
  echo "cd ~/">>$NUNU
  echo "echo ''">>$NUNU
  echo "cd ~/">>$NUNU
  chmod +x /usr/bin/nunu
}
userinstall_arduino(){
  cd "$USERSOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ
}
#########################################################################################

show_logo
mkdir -p $TMPDIR
echo -e "\e[1;49;33mtemp dir created in : $TMPDIR\e[0m"
echo -e "\e[95mYou need to enter your sudo password to install pacakges\e[0m"
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

while IFS= read -r line || [[ -n "$line" ]]; do
    if [ $(dpkg-query -W -f='${Status}' $line 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
  	  echo -e "\e[1;49;32m -> installation de : \e[1;49;33m $line \e[0m";
	  echo ""
#	  sudo apt install -y $line 
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
  	  echo -e "\e[1;95m -> suppression de : \e[1;95;33m $line \e[0m";
	  echo 
#	  sudo apt remove -y $line 
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


## create "ser" command to serve directory (using node http-server)
echo -e  "\e[1;49;32mCréer la commande ser (pour lancer rapidement un serveur local)?\e[0m"
read -p "oui= o ou y | non = n :: " -n 1 -r
echo    
if [[ $REPLY =~ ^[YyOo]$ ]]
then
  echo -e "\e[1mCreating ser command\e[0m"
  echo -e "\e[1min /usr/bin/ser\e[0m"
  FILE="/usr/bin/ser"
  echo '#!/bin/bash'>>$FILE
  echo 'type http-server >/dev/null 2>&1 || { echo >&2 "you need to install http-server (npm install http-server)"; exit 1; }'>>$FILE
  echo 'if [ "$1" == "stop" ]; then'>>$FILE
  echo 'p=$(pidof http-server)'>>$FILE
  echo 'kill $p'>>$FILE
  echo 'echo "extinction du serveur: "$p'>>$FILE
  echo 'else'>>$FILE
  echo 'http-server -a localhost &'>>$FILE
  echo 'p=$(pidof http-server)'>>$FILE
  echo 'echo "PID : "$p'>>$FILE
  echo 'echo "to stop : ser stop"'>>$FILE
  echo 'fi'>>$FILE
  chmod +x /usr/bin/ser
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
