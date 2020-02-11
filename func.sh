#!/bin/bash

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
  echo -e "\e[1;49;32m          ( created and tested on Linux Mint)            \e[0m"  
  echo -e "\e[1;49;32m ____________________________________________________________\e[0m"
  echo
}

apt_maintenance(){
echo
echo -e "\e[1;49;32m-> updating APT (update)\e[0m";
sudo apt update
echo -e "\e[1;49;32m-> some cleaning APT (autoremove) \e[0m";
sudo apt-get autoremove -y
echo -e "\e[1;49;32m-> more cleaning APT (autoclean) \e[0m";
sudo apt-get autoclean
echo
}

create_ser(){
  echo
  echo -e "\e[1;49;33m*************************************\e[0m"
  echo -e "\e[1;49;33mCreating command ser (/usr/bin/ser)\e[0m"
  echo -e "\e[1;49;33m*************************************\e[0m"
  if [ -e "/usr/bin/ser" ]; then
    echo -e "\e[1;49;32mremoving existing /usr/bin/ser"
    sudo rm -f /usr/bin/ser
  fi 
  sudo cp -v $AUTOCONFDIR/data/ser /usr/bin/ser
  sudo chmod +x /usr/bin/ser
}

install_rtl8821(){
  echo 
  echo -e "\e[1m==========  Installing WIFI DRIVER RTL8821  ==========\e[0m" 
  sudo apt-get install --reinstall git dkms build-essential linux-headers-$(uname -r)
  cd  "$TMPDIR"||echo -e "\e[101mProblemn cd to TMPDIR.\e[0m"
  git clone https://github.com/tomaspinho/rtl8821ce --progress
  cd rtl8821ce||echo -e "\e[101mError entering dir rtl8821ce.\e[0m"
  chmod +x dkms-install.sh
  chmod +x dkms-remove.sh
  sudo ./dkms-install.sh
}

install_nunustudio(){
  echo 
  echo -e "\e[1m=============  Downloading nunuStudio in ~/logiciels nunuStudio.zip ===============\e[0m"  
  wget -qO ~/logiciels/nunuStudio.zip "https://github.com/tentone/nunuStudio/archive/master.zip" --show-progress
  echo -e "\e[1;49;33m*************************************\e[0m"
  echo -e "\e[1;49;33mCreating command nunu (/usr/bin/nunu)\e[0m"
  echo -e "\e[1;49;33m*************************************\e[0m"
  if [ -e "/usr/bin/nunu" ]; then
    echo -e "\e[1;49;32mremoving existing /usr/bin/nunu"
    sudo rm -f /usr/bin/nunu
  fi   
  sudo cp -v $AUTOCONFDIR/data/nunu /usr/bin/nunu
  sudo chmod +x /usr/bin/nunu
}
## restore bash profile
set_bashprofile(){
 echo 
 echo -e "\e[1m===========  Restoring bash profile  ==============\e[0m"
 cp -v $AUTOCONFDIR/data/.bashrc $HOME/.bashrc
 cp -v $AUTOCONFDIR/data/.profile $HOME/.profile
}
install_arduino(){
  cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  echo 
  echo -e "\e[1m==============  Installing ArduinoIDE  ==============\e[0m" 
  curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ
}
install_charles(){
  echo 
  echo -e "\e[1m==============  Installing Charles-Proxy  ==============\e[0m"
  wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
  sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
  sudo apt update
  sudo apt install charles-proxy
}
install_bootrepair(){
  echo 	
  echo -e "\e[1m==============  Installing BOOT-REPAIR  ================\e[0m"
  sudo add-apt-repository -y ppa:yannubuntu/boot-repair
  sudo apt-get -y update
  sudo apt-get install -y boot-repair
}

install_micro(){
  echo 
  echo -e "\e[1m==============  Installing MICRO  ======================\e[0m"
  wget -O "$TMPDIR"/mic https://getmic.ro && bash "$TMPDIR"/mic
  sudo mv $AUTOCONFDIR/micro /usr/bin/micro
}
install_nvm(){
  echo	
  echo -e "\e[1m==============  Installing NVM  =========================\e[0m"
  wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" --show-progress |bash 
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use node
  # chown -R $USER:$(id -gn $USER) $HOME/.config
  nvm install-latest-npm 
}
install_atom(){
  echo	
  echo -e "\e[1m==============  Installing ATOM  =========================\e[0m"
  wget -O $TMPDIR/atomdeb https://atom.io/download/deb  -q --show-progress --progress=bar:force 2>&1
  sudo dpkg -i $TMPDIR/atomdeb  
}


