#!/bin/bash
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

sudo -s
# installation of zippers and unzippers
apt install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract
#softwares from 'normal' repositories / essential
apt install -y apt-transport-https build-essential libssl-dev openssl software-properties-common python-software-properties zlib1g zlib1g-dev libsecret-1-dev libx11-dev libxkbfile-dev libpcre3 libpcre3-dev
apt install -y fakeroot rpm git httpie ffmpeg
# systems tools / misc
apt install -y gparted inxi htop ksysguard hardinfo searchmonkey deepin-terminal wine
apt install -y  dconf-cli dconf-editor hardinfo ppa-purge
# text / media : editor / visualizer
apt install -y sublime-text gedit sqlitebrowser darktable audacity vlc ATOM
# web
apt remove transmission-common transmission-gtk hexchat
apt install youtube-dl youtube-dlg chromium-browser qbittorrent filezilla rclone rclonetray torbrowser-launcher

###############################################################################################
## create "ser" command to serve directory (using node http-server)
echo "creating ser command : /usr/bin/ser ...."
FILE="/usr/bin/ser" 
echo '#!/bin/bash'>>$FILE
echo 'type http-server >/dev/null 2>&1 || { echo >&2 "you need to install http-server (npm install http-server)"; exit 1; }'>>$FILE
echo 'if [ "$1" == "stop" ]; then'>>$FILE
echo 'p=$(pidof http-server)'>>$FILE
echo 'kill $p'>>$FILE
echo 'echo "extinction serveur: "$p'>>$FILE
echo 'else'>>$FILE
echo 'http-server -a localhost &'>>$FILE
echo 'p=$(pidof http-server)'>>$FILE
echo 'echo "PID : "$p'>>$FILE
echo 'echo "to stop : ser stop"'>>$FILE
echo 'fi'>>$FILE
chmod +x /usr/bin/ser

# misc softwares
# Atom
 wget -O ~/$TMPDIR/atomdeb https://atom.io/download/deb  -q --show-progress --progress=bar:force 2>&1
 dpkg -i ~/$TMPDIR/atomdeb
 rm -f ~/$TMPDIR/atomdeb
 
# Boot-repair
add-apt-repository -y ppa:yannubuntu/boot-repair
apt-get -y update
apt-get install -y boot-repair

#sh software/install-atom.sh
# Charle-proxy
wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
apt update
apt install charles-proxy

# create softwares folder (logiciels)
mkdir -p ~/home/$USER/logiciels
cd ~/logiciels

# Nunustudio
git clone https://github.com/tentone/nunuStudio --progress
NUNU='/usr/bin/nunu'
echo "#!/bin/bash">>$NUNU
echo "cd ~/logiciels/nunuStudio">>$NUNU
echo "npm start & ">>$NUNU
echo "echo ''">>$NUNU
echo "echo '+++++++++ au boulot ++++++++++++'">>$NUNU
echo "cd ~/">>$NUNU
echo "echo ''">>$NUNU
echo "cd ~/">>$NUNU
chmod +x /usr/bin/nunu

# install arduino IDE
echo "++++ installation ARDUINO IDE ++++++++++"
cd ~/
mkdir -p logiciels && cd logiciels
curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ


echo "################################################################"
echo "##################    core software installed  #################"
echo "################################################################"
