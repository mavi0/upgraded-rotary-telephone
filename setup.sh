#!/bin/bash

# $1 = IP of setup server
# $2 = Remote SSH port to bind to for AutoSSH reverse proxy

# THIS WILL NEED EDITING FOR ARM 

## Install Prerequsites
echo -e "\e[33mInstalling required packages \e[39m"
#wget "$1:5000/clone/sources.list"
#sudo mv sources.list /etc/apt/sources.list

# wget wget https://repo.zabbix.com/zabbix/4.0/raspbian/pool/main/z/zabbix-release/zabbix-release_4.0-2+stretch_all.deb
# sudo dpkg -i zabbix-release_4.0-2+bionic_all.deb
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y python3 python iperf3 python-pip python3-pip speedtest-cli golang-go autossh moreutils openvpn git
sudo pip3 install iperf3 pingparsing jsonmerge
sudo pip install yoctopuce

# ## SSH setup
# echo -e "\e[33mSetting up SSH config \e[39m"
# cd ~/.ssh/
# wget "$1:5000/clone/authorized_keys"
# wget "$1:5000/clone/config"
# wget "$1:5000/clone/id_rsa"
# wget "$1:5000/clone/id_rsa.pub"

## Make Working directories
echo -e "\e[33mMaking working directories \e[39m"
cd ~/
mkdir clone
mkdir perf
ls -al
cd clone

# ## Generate autossh service file
# echo -e "\e[33mgenerating AutoSSH service files \e[39m"
# FILE="autossh.service"

# /bin/cat <<EOM >$FILE
# [Unit]
# Description=AutoSSH tunnel service
# After=network.target

# [Service]
# Environment="AUTOSSH_GATETIME=0"
# User=arisaie
# ExecStart=/usr/bin/autossh -N -F /home/arisaie/.ssh/config -i /home/arisaie/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -R $2:localhost:22 athena

# [Install]
# WantedBy=multi-user.target

# EOM
# cat autossh.service

## Install AutoSSH Service
# echo -e "\e[33mInstalling AutoSSH server files \e[39m"
# sudo cp -v autossh.service /etc/systemd/system/autossh.service
# sudo systemctl daemon-reload
# sudo systemctl enable autossh.service
# sudo systemctl start autossh.service

# ## Get HTTP server file
# echo -e "\e[33mGetting HTTP server service files \e[39m"
# wget "$1:5000/clone/simplehttp.service"

# ## Install HTTP Server Service
# echo -e "\e[33mInstalling HTTP server service files \e[39m"
# sudo cp -v simplehttp.service /etc/systemd/system/simplehttp.service
# sudo systemctl daemon-reload
# sudo systemctl enable simplehttp.service
# sudo systemctl start simplehttp.service

## Generate Hostname var
HOSTNAME= hostname

# Get VPN conf file
echo -e "\e[33mGetting VPN files \e[39m"

wget "$1:5000/clone/$HOSTNAME.ovpn"

## Install VPN service
echo -e "\e[33minstalling VPN files \e[39m"
sudo cp -v $HOSTNAME.ovpn /etc/openvpn/sixtimes.conf
sudo systemctl daemon-reload
sudo systemctl enable openvpn@sixtimes.service
sudo systemctl start openvpn@sixtimes.service

# ## Configure Zabbix
# echo -e "\e[33mConfiguring Zabbix\e[39m"
# wget "$1:5000/clone/zabbix_agentd.conf"

# sed -i "150s/.*/Hostname=$HOSTNAME/" zabbix_agentd.conf

# sudo cp -v zabbix_agentd.conf /etc/zaybbix/zabbix_agentd.conf
# sudo systemctl enable zabbix-agent
# sudo systemctl restart zabbix-agent

## Clone repos and install crontab

echo -e "\e[33mCloning repositories...\e[39m"
cd ~/perf
git clone https://github.com/mavi0/upgraded-rotary-telephone.git
sudo crontab upgraded-rotary-telephone/cronjobs

# echo -e "\e[33m$2\e[39m"
ifconfig
