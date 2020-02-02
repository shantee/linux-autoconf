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
apt install -y apt-transport-https openssl software-properties-common python-software-properties git zlib1g zlib1g-dev libpcre3 libpcre3-dev build-essential libssl-dev httpie ffmpeg
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
echo "creating ser command : /bin/ser ...."
cat <<EOF >/bin/ser
#!/bin/bash
type http-server >/dev/null 2>&1 || { echo >&2 "you need to install http-server (npm install http-server)"; exit 1; }
if [ "$1" == "stop" ]; then
p=$(pidof http-server)
kill $p
echo "extinction serveur: "$p
else
    http-server -a localhost &
    p=$(pidof http-server)
    echo "PID : "$p
fi
EOF 

# misc softwares
# Atom
#sh software/install-atom.sh

# create softwares folder (logiciels)
mkdir -p ~/home/$USER/logiciels
cd ~/logiciels

# Nunustudio
git clone https://github.com/tentone/nunuStudio --progress
# install arduino IDE
cd ~/
mkdir -p logiciels && cd logiciels
curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ


echo "################################################################"
echo "##################    core software installed  #################"
echo "################################################################"
