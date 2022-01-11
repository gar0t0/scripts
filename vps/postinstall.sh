#!/bin/bash
## gar0t0 - 11/01/2022
## script vps install tools

## Variables
LOG_FILE="/root/postinstall.log"
TOOLS_DIR="/root/tools"
DATE=$(date "+%Y%m%d - %H:%m:%S")
golang_package="https://go.dev/dl/go1.17.6.linux-amd64.tar.gz"
anew="go get -u github.com/tomnomnom/anew"
assetfinder="go get -u github.com/tomnomnom/assetfinder"
dnsx="go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
ffuf="go get -u github.com/ffuf/ffuf"
gospider="go get -u github.com/jaeles-project/gospider"
hakrawler="go install github.com/hakluke/hakrawler@latest"
httpx="go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
interactsh_client="go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
interactsh_server="go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-server@latest"
nikto="git clone https://github.com/sullo/nikto $TOOLS_DIR/nikto"
jaeles="go get github.com/jaeles-project/jaeles"
notify="go install -v github.com/projectdiscovery/notify/cmd/notify@latest"
nuclei="go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest"
nuclei_templates="git clone https://github.com/projectdiscovery/nuclei-templates.git $TOOLS_DIR/nuclei-templates"
proxify="go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest"
subfinder="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
waybackurls="go get github.com/tomnomnom/waybackurls"

## Start script
echo -e "====== Starting post install Script - $DATE ======\nCheck all tools after install" >> $LOG_FILE 2>&1

## Create tools directory
echo -e "====== Creating $TOOLS_DIR directory - $DATE ======\nCheck all tools after install" >> $LOG_FILE 2>&1
mkdir "$TOOLS_DIR"

## Pre-Req
echo -e "====== Starting apt process - $DATE ======\n" >> $LOG_FILE 2>&1
{ apt update
  apt install git vim wget curl perl gcc -y 
} >> $LOG_FILE 2>&1
echo -e "====== Ending apt process - $DATE ======\n" >> $LOG_FILE 2>&1

## go install
echo -e "====== Starting golang install - $DATE ======\n" >> $LOG_FILE 2>&1
{ wget $golang_package -O /tmp/golang-latest.tar.gz
  tar -xf /tmp/golang-latest.tar.gz -C /usr/local
  echo 'export PATH="$PATH:/usr/local/go/bin:~/go/bin"' >> ~/.bashrc
  echo 'export GOPATH=/root/go' >> ~/.bashrc
} >> $LOG_FILE 2>&1

## Exporting go variables
export PATH="$PATH:/usr/local/go/bin:~/go/bin"
export GOPATH="/root/go"
export GOROOT="/usr/local/go"
export GOCACHE="/root/.cache/go-build"
export HOME="/root"
echo -e "====== Ending golang install - $DATE ======\n" >> $LOG_FILE 2>&1

## For loop to easy installation
echo "====== Starting packages install - $DATE ======" >> $LOG_FILE 2>&1
{
    $anew
    $assetfinder
    $dnsx
    $ffuf
    $gospider
    $hakrawler
    $httpx
    $interactsh_client
    $interactsh_server
    $nikto
    $jaeles
    $notify
    $nuclei
    $nuclei_templates
    $proxify
    $subfinder
    $waybackurls
} >> $LOG_FILE 2>&1
ln -s $TOOLS_DIR/nikto/program/nikto.py /usr/local/bin/nikto
echo "====== Ending packages install - $DATE ======" >> $LOG_FILE 2>&1

## Finishing script
echo "====== Finishing post install script - $DATE ======" >> $LOG_FILE 2>&1