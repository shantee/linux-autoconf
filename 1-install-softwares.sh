#!/bin/bash
. $(dirname "$0")/necho.sh
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
TMPDIR="$HOME/autoinstalltmp"
SOFTDIR="$HOME/Logiciels"
sudo -s
echo -e "\e[44mInstallation of various libraries and usefull softwares\e[0m" #blue text and back to normal
# installation of zippers and unzippers
apt install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract
apt install -y apt-transport-https build-essential libssl-dev openssl software-properties-common python-software-properties zlib1g zlib1g-dev libsecret-1-dev libx11-dev libxkbfile-dev libpcre3 libpcre3-dev
echo "-------------------------------------------------"
echo -e "\e[42m Let's install : fakeroot, rpm, git, httpie, ffmpeg, inxi\e[0m"
sleep 2
apt install -y fakeroot rpm git httpie ffmpeg inxi htop
# systems tools / misc
apt install -y gparted ksysguard ha\e[0mrdinfo searchmonkey deepin-terminal wine
apt install -y  dconf-cli dconf-editor hardinfo ppa-purge
# text / media : editor / visualizer
apt install -y sublime-text gedit sqlitebrowser darktable audacity vlc
echo ""
echo -e " \e[44mInstalling micro (terminal text editor)\e[0m"
wget -O "$TMPDIR"/mic https://getmic.ro && bash "$TMPDIR"/mic
mv "$TMPDIR"/micro /usr/bin/micro

# web
apt remove transmission-common transmission-gtk hexchat
apt install youtube-dl youtube-dlg chromium-browser qbittorrent filezilla rclone rclonetray torbrowser-launcher
apt install nmap zenmap
###############################################################################################
## create "ser" command to serve directory (using node http-server)

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

# misc softwares
# Atom
echo -e "\e[1mInstalling Atom\e[0m"
 wget -O $TMPDIR/atomdeb https://atom.io/download/deb  -q --show-progress --progress=bar:force 2>&1
 dpkg -i $TMPDIR/atomdeb
 rm -f $TMPDIR/atomdeb
 
# Boot-repair
echo -e "\e[1mInstalling Boot-Repair\e[0m"
add-apt-repository -y ppa:yannubuntu/boot-repair
apt-get -y update
apt-get install -y boot-repair

# Charle-proxy
echo -e "\e[1mInstalling Charles-Proxy\e[0m"
wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
apt update
apt install charles-proxy

# create softwares folder (logiciels)
mkdir -p $SOFTDIR

# Nunustudio
echo -e "\e[1mInstalling Nunustudio\e[0m"
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

# install arduino IDE
echo "\e[102m++++ installation ARDUINO IDE ++++++\e[0m"
cd "$HOME"||echo -e "\e[101mProblemn changing dir.\e[0m"
mkdir -p "$SOFTDIR" && cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ

echo "################################################################"
echo "##################    core software installed  #################"
echo "################################################################"
