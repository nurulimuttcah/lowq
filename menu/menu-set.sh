#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/nurulimuttcah/licensi/main/ipmini | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mSTATUS SCRIPT AKTIF...\e[0m"
    else
    echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m";
    
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/nurulimuttcah/licensi/main/ipmini | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
CEKEXPIRED
else
echo -e "\e[31mPermission Denied!\e[0m";

exit 0
fi
clear 
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m          • SISTEM MENU •          \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " [\e[36m•01\e[0m] Panel Domain"
echo -e " [\e[36m•02\e[0m] Ubah Port Semua Akun"
echo -e " [\e[36m•03\e[0m] Webmin Menu"
echo -e " [\e[36m•34\e[0m] Speedtest VPS"
echo -e " [\e[36m•05\e[0m] Tentang Script"
echo -e " [\e[36m•56\e[0m] Set Auto Reboot"
echo -e " [\e[36m•07\e[0m] Mulai Ulang Semua Layanan"
echo -e " [\e[36m•08\e[0m] mengubah Banner"
echo -e " [\e[36m•09\e[0m] Cek Bandwith"
echo -e " [\e[36m•10\e[0m] Menu DNS"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mKembali Ke Menu\033[0m"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • Untuk-Keluar"
echo -e   ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-domain ; exit ;;
2) clear ; port-change ; exit ;;
3) clear ; menu-webmin ; exit ;;
4) clear ; speedtest ; exit ;;
5) clear ; about ; exit ;;
6) clear ; auto-reboot ; exit ;;
7) clear ; restart ; exit ;;
8) clear ; nano /etc/issue.net ; exit ;; #ssh-vpn banner.conf
9) clear ; bw ; exit ;;
10) clear ; dns ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "" ; echo "Anda salah tekan" ; sleep 1 ; menu-set ;;
esac
