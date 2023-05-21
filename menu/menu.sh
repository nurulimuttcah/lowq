#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Premium Auto Script 4.2"

# Color Validation
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]${NC}"
else
status_xray="${RB}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]${NC}"
else
status_nginx="${RB}[ OFF ]${NC}"
fi
clear
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e "           ${WB}༶ ━━━━━ [ LYNZ PROJECT ] ━━━━━ ༶${NC}       "
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e " ${YB}Service Provider${NC} ${WB}: $ISP${NC}"
echo -e " ${YB}Timezone${NC}         ${WB}: $WKT${NC}"
echo -e " ${YB}City${NC}             ${WB}: $CITY${NC}"
echo -e " ${YB}Date${NC}             ${WB}: $DATE${NC}"
echo -e " ${YB}Domain${NC}           ${WB}: $domain${NC}"
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e "          ${WB}༶ ━━━━━ [ Bandwidth Monitoring ] ━━━━━ ༶${NC}"
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e "       ${GB}Today ($DATE)       Monthly ($(date +%B/%Y))${NC}  "
echo -e "          ${GB}↓↓ Down: $dtoday                  ↓↓ Down: $dmon${NC}   "
echo -e "          ${GB}↑↑ Up  : $utoday                  ↑↑ Up  : $umon${NC}   "
echo -e "          ${GB}≈ Total: $ttoday                  ≈ Total: $tmon${NC}   "
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e "                ${WB}༶ ━━━━━ [ ALL MENU ] ━━━━━ ༶${NC}               "
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e " [\e[5m01\e[0m] SSH & OpenVPN Menu"       
echo -e " [\e[5m02\e[0m] Xray Vmess Menu"          
echo -e " [\e[5m03\e[0m] Xray Vless Menu"          
echo -e " [\e[5m04\e[0m] Trojan Go Menu" 
echo -e " [\e[5m05\e[0m] Trojan GFW & GRPC Menu" 
echo -e " Menu Tambahan" | lolcat -a -d 10
echo -e " [\e[5m06\e[0m] Hapus RAM Cache"
echo -e " [\e[5m07\e[0m] Status Server"
echo -e " [\e[5m08\e[0m] Panel Domain"
echo -e " [\e[5m09\e[0m] Port Menu"
echo -e " [\e[5m10\e[0m] Webmin Menu"
echo -e " [\e[5m11\e[0m] Speedtest VPS"
echo -e " [\e[5m12\e[0m] Tentang Script"
echo -e " [\e[5m13\e[0m] Set Auto Reboot"
echo -e " [\e[5m14\e[0m] Restart All Layanan"
echo -e " [\e[5m15\e[0m] Ganti Banner"
echo -e " [\e[5m16\e[0m] Cek Pengunaan Bandwith"
echo -e " [\e[5m17\e[0m] Cek Monitoring CPU"
echo -e " [\e[5m18\e[0m] Aktifkan Bot Telegram"
echo -e " [\e[5m19\e[0m] Menu DNS"
echo -e " [\e[5m20\e[0m] Media Stream Unbloker Test"
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e "          ${WB}༶ ━━━━━ [ AUTO SCRIPT LYNZ ] ━━━━━ ༶${NC}               "
echo -e "${BB}═════════════════════════════════════════════════════════════${NC}"
echo -e   ""
read -p " Pilih menu :  "  opt
echo -e   ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trgo ;;
5) clear ; menu-trojan ;;
6) clear ; clearcache ;;
7) clear ; running ;;
8) clear ; menu-domain ; exit ;;
9) clear ; port-change ; exit ;;
10) clear ; menu-webmin ; exit ;;
11) clear ; speedtest ; exit ;;
12) clear ; about ; exit ;;
13) clear ; auto-reboot ; exit ;;
14) clear ; restart ; exit ;;
15) clear ; nano /etc/issue.net ; exit ;; #ssh-vpn banner.conf
16) clear ; bw ; exit ;;
17) clear ; htop ; exit ;;
18) clear ; python3 -m xolpanel ; exit ;;
19) clear ; dns ; exit ;;
20) clear ; netf ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
esac
