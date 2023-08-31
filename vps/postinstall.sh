#!/bin/bash
## gar0t0 - 11/01/2022
## script vps install tools
## Merge with 0xtiago script -> https://github.com/0xtiago/vps_config/blob/main/run.sh

## Variables
LOG_FILE="/root/postinstall.log"
TOOLS_DIR="/root/tools"
DATE=$(date "+%Y%m%d - %H:%m:%S")
golang_package="https://go.dev/dl/go1.21.0.linux-amd64.tar.gz"

## Packages
amass="go install -v github.com/owasp-amass/amass/v4/...@master"
anew="go get -u github.com/tomnomnom/anew@latest"
antiburl="https://raw.githubusercontent.com/tomnomnom/hacks/master/anti-burl/main.go"
arjun="pip install arjun"
assetfinder="go get -u github.com/tomnomnom/assetfinder"
axiom="bash <(curl -s https://raw.githubusercontent.com/pry0cc/axiom/master/interact/axiom-configure)"
chaos_client="go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
collector="https://raw.githubusercontent.com/m4ll0k/BBTz/master/collector.py"
dalfox="go install github.com/hahwul/dalfox/v2@latest"
dirsearch="git clone https://github.com/maurosoria/dirsearch.git ${TOOLS_DIR}/dirsearch"
dnsx="go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
ffuf="go install github.com/ffuf/ffuf/v2@latest"
findomain="https://github.com/findomain/findomain/releases/latest/download/findomain-linux"
gau="go install github.com/lc/gau/v2/cmd/gau@latest"
gauplus="go install github.com/bp0lr/gauplus@latest"
gf="go get -u github.com/tomnomnom/gf"
gitdorker="git clone https://github.com/obheda12/GitDorker.git ${TOOLS_DIR}/gitdorker"
gitdumper="pip install git-dumper"
gitscanner="git clone https://github.com/HightechSec/git-scanner ${TOOLS_DIR}/gitscanner"
githubsearch="git clone https://github.com/gwen001/github-search.git ${TOOLS_DIR}/githubsearch"
gospider="go install github.com/jaeles-project/gospider@latest"
gowitness="go install github.com/sensepost/gowitness@latest"
hakrawler="go install github.com/hakluke/hakrawler@latest"
haktrails="go install -v github.com/hakluke/haktrails@latest"
httprobe="go install github.com/tomnomnom/httprobe@latest"
httpx="go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
interactsh_client="go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
interactsh_server="go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-server@latest"
nikto="git clone https://github.com/sullo/nikto ${TOOLS_DIR}/nikto"
jaeles="go install github.com/jaeles-project/jaeles@latest"
jsscanner="git clone https://github.com/0x240x23elu/JSScanner.git ${TOOLS_DIR}/jsscanner"
kiterunner="https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz"
linkfinder="git clone https://github.com/GerbenJavado/LinkFinder.git ${TOOLS_DIR}/linkfinder"
mapcidr="go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest"
massdns="git clone https://github.com/blechschmidt/massdns.git ${TOOLS_DIR}/massdns"
metabigor="go install github.com/j3ssie/metabigor@latest"
metasploit="https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb"
naabu="go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
notify="go install -v github.com/projectdiscovery/notify/cmd/notify@latest"
nuclei="go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest"
nuclei_templates="git clone https://github.com/projectdiscovery/nuclei-templates.git ${TOOLS_DIR}/nuclei-templates"
paramspider="git clone https://github.com/devanshbatham/ParamSpider ${TOOLS_DIR}/paramspider"
proxify="go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest"
qsreplace="go install github.com/tomnomnom/qsreplace@latest"
shuffledns="go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
sub404="git clone https://github.com/r3curs1v3-pr0xy/sub404.git ${TOOLS_DIR}/sub404"
subfinder="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
subjs="go install github.com/lc/subjs@latest"
turbosearch="pip install git+https://github.com/helviojunior/turbosearch.git#egg=turbosearch"
unfurl="go install github.com/tomnomnom/unfurl@latest"
waybackurls="go install github.com/tomnomnom/waybackurls@latest"
wpscam="gem install wpscan"

## Start script
echo -e "====== Starting post install Script - ${DATE} ======\nCheck all tools after install" >> ${LOG_FILE} 2>&1

## Validate root user
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
fi
## Create tools directory
echo -e "====== Creating ${TOOLS_DIR} directory - ${DATE} ======\nCheck all tools after install" >> ${LOG_FILE} 2>&1
mkdir "${TOOLS_DIR}"

## Pre-Req
echo -e "====== Starting apt process - ${DATE} ======\n" >> ${LOG_FILE} 2>&1
{ apt update
  apt install git vim wget curl perl gcc jq htop zsh default-jre net-tools locate gzip zip ruby-dev tmux p7zip libpcap-dev python3-pip snap nmap sqlmap john grepcidr masscan brutespray prips fonts-powerline -y 
} >> ${LOG_FILE} 2>&1
echo -e "====== Ending apt process - ${DATE} ======\n" >> ${LOG_FILE} 2>&1

## go install
echo -e "====== Starting golang install - ${DATE} ======\n" >> ${LOG_FILE} 2>&1
{ wget $golang_package -O /tmp/golang-latest.tar.gz
  tar -xf /tmp/golang-latest.tar.gz -C /usr/local
  echo 'export PATH="$PATH:/usr/local/go/bin:~/go/bin"' >> ~/.bashrc
  echo 'export GOPATH=/root/go' >> ~/.bashrc
} >> ${LOG_FILE} 2>&1

## Exporting variables
export PATH="$PATH:/usr/local/go/bin:~/go/bin"
export GOPATH="/root/go"
export GOROOT="/usr/local/go"
export GOCACHE="/root/.cache/go-build"
export HOME="/root"
echo "====== Ending golang install - ${DATE} ======" >> ${LOG_FILE} 2>&1

## For loop to easy installation
echo "====== Starting packages install - ${DATE} ======" >> ${LOG_FILE} 2>&1
{
    $amass
    $anew
    wget $antiburl -O /tmp/main.go && cd /tmp && go build main.go && mv main $HOME/go/bin/anti-burl && rm -f main.go
    $arjun
    $assetfinder
    $axiom
    $chaos_client
    wget $collector -O /tmp/collector.py && chmod +x /tmp/collector.py && sed -i '#!/usr/bin/env python3' /tmp/collector.py && mv /tmp/collector.py /usr/local/bin/collector.py
    $dalfox
    $dirsearch && cd ${TOOLS_DIR}/dirsearch && pip install -r requirements.txt && chmod +x dirsearch.py
    $dnsx
    $ffuf
    wget $findomain -O /tmp/findomain && chmod +x /tmp/findomain && mv /tmp/findomain /usr/local/bin/
    $gau
    $gauplus
    $gf
    $gitdorker && cd ${TOOLS_DIR}/gitdorker && pip install -r requirements.txt && chmod +x GitDorker.py
    $gitdumper
    $gitscanner && chmod +x ${TOOLS_DIR}/gitscanner/gitscanner.sh
    $githubsearch && cd ${TOOLS_DIR}/githubsearch && pip install -r requirements3.txt && chmod +x github-subdomains.py
    $gospider
    $gowitness
    $hakrawler
    $haktrails
    $httprobe
    $httpx
    $interactsh_client
    $interactsh_server
    $nikto
    $jaeles
    $jsscanner && cd ${TOOLS_DIR}/jsscanner && pip install -r requirements.txt && chmod +x JSScanner.py
    wget $kiterunner -O /tmp/kiterunner.tar.gz && tar -xf /tmp/kiterunner.tar.gz -C /usr/local/bin
    $linkfinder && cd ${TOOLS_DIR}/linkfinder && pip install -r requirements.txt && python3 setup.py install
    $mapcidr
    $massdns && cd  ${TOOLS_DIR}/massdns && make && chmod +x ${TOOLS_DIR}/massdns/bin/massdns
    $metabigor
    curl $metasploit > /tmp/msfinstall && chmod 755 /tmp/msfinstall && cd /tmp && ./msfinstall && msfupdate && rm -f /tmp/msfinstall
    $naabu
    $notify
    $nuclei
    $nuclei_templates
    $paramspider && cd ${TOOLS_DIR}/paramspider && pip install -r requirements.txt && chmod +x paramspider.py
    $proxify
    $qsreplace
    $shuffledns
    $sub404 && cd ${TOOLS_DIR}/sub404 && pip install -r requirements.txt && chmod +x sub404.py
    $subfinder
    $subjs
    $turbosearch
    $unfurl
    $waybackurls
    $wpscam
} >> ${LOG_FILE} 2>&1

## Create aliases
ln -s ${TOOLS_DIR}/nikto/program/nikto.pl /usr/local/bin/nikto
ln -s ${TOOLS_DIR}/dirsearch/dirsearch.py /usr/local/bin/dirsearch
ln -s ${TOOLS_DIR}/gitdorker/GitDorker.py /usr/local/bin/gitdorker
ln -s ${TOOLS_DIR}/gitscanner/gitscanner.sh /usr/local/bin/gitscanner
ln -s ${TOOLS_DIR}/githubsearch/github-subdomains.py /usr/local/bin/github-subdomains
ln -s ${TOOLS_DIR}/jsscanner/JSScanner.py /usr/local/bin/jsscanner
ln -s ${TOOLS_DIR}/linkfinder/linkfinder.py /usr/local/bin/linkfinder
ln -s ${TOOLS_DIR}/massdns/bin/massdns /usr/local/bin/massdns
ln -s ${TOOLS_DIR}/paramspider/paramspider.py /usr/local/bin/paramspider
ln -s ${TOOLS_DIR}/sub404/sub404.py /usr/local/bin/sub404

echo "====== Ending packages install - ${DATE} ======" >> ${LOG_FILE} 2>&1

## Finishing script
echo "====== Finishing post install script - ${DATE} ======" >> ${LOG_FILE} 2>&1
