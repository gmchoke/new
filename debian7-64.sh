#!/bin/bash
#
# Original script by fornesia, rzengineer and fawzya
# Mod by Bustami Arifin
# ==================================================
# go to root #sudo su

cd
sudo apt-get update
#apt-get install ca-certificates
apt-get install zip
#apt-get install unzip
apt-get -y install openvpn

# Change to Time GMT+8
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://docs.google.com/uc?export=download&id=1VsWCjCWk0kZWGsc0dHTyV72bSq353aMo"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://docs.google.com/uc?export=download&id=1AHCx3l189oQ8FL10ztYvvYZ1Gk4Vqx9l"
#service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://docs.google.com/uc?export=download&id=1coGDXz7VacDMTP_dYsiQXZyXhB8aDXxu"
chmod +x /etc/network/if-up.d/iptables
service openvpn restart
#service openvpn status

# download script
cd /usr/bin
wget -O usernew "https://docs.google.com/uc?export=download&id=1Z5bEI7Q1cCoI5yqD9wDx6Mx-kPaYJRMp"
chmod +x usernew
# Add User OpenVPN key: usernew


# Install Squid
apt-get -y install squid3
cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig
wget -O /etc/squid3/squid.conf "https://docs.google.com/uc?export=download&id=1ynLQwUiKvN5ztB-3n6TH-KdoiEBmSvEF"
MYIP=$(wget -qO- ipv4.icanhazip.com);
sed -i s/xxxxxxxxx/$MYIP/g /etc/squid3/squid.conf;
service squid3 restart


# install webmin
cd
#wget -O webmin-current.deb "https://docs.google.com/uc?export=download&id=1R6V8edVQtIeHYdvZB2EH0sGCLRh2sepm"
#dpkg -i --force-all webmin-current.deb;
#apt-get -y -f install;
#rm /root/webmin-current.deb
			#sed -i s/port=10000/port=85/g /etc/webmin/miniserv.conf;
sudo tee -a /etc/apt/sources.list << EOF
deb http://download.webmin.com/download/repository sarge contrib
deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib
EOF
cd /root
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update
apt-get install webmin
sed -i s/ssl=1/ssl=0/g /etc/webmin/miniserv.conf;
service webmin restart


# Web Based Interface for Monitoring Network apache2 php5 php5-gd
sudo apt-get install vnstat
sudo apt-get install apache2 php5 php5-gd
wget -O vnstat_php_frontend-1.5.1.tar.gz "https://docs.google.com/uc?export=download&id=1VxkpjE75i3K6ku2AUate1Q-YEndNhzFR"
#wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xzf vnstat_php_frontend-1.5.1.tar.gz
cd
rm /var/www/index.html
cp -r  ./vnstat_php_frontend-1.5.1/* /var/www
sed -i s/nl/th/g /var/www/config.php;
wget -O /var/www/lang/th.php "https://docs.google.com/uc?export=download&id=1Tezcbh8WIcsr1RZW1LRR1tBqD953GACZ"
wget -O /var/www/index.php "https://docs.google.com/uc?export=download&id=1bkK_IbQUrZblo7WQPbOav32mtQzFniuT"
sed -i s/xxxxxxxxxx/http/g /var/www/index.php;
sed -i s/client.zip/client.php/g /var/www/index.php;
wget -O /var/www/openvpn-as.png "https://docs.google.com/uc?export=download&id=1cmgyFpofMxFMQApLf2G4C7woQCc032rf"
sed -i s/85/10000/g /var/www/index.php;
cd
rm -rf vnstat_php_frontend-1.5.1
rm vnstat_php_frontend-1.5.1.tar.gz
cd
wget -O client.ovpn "https://docs.google.com/uc?export=download&id=1mEW2-EZgHp83oGmZkhiOiX5P_ZQP9oHv"
sed -i s/xxxxxxxx/$MYIP/g client.ovpn;
#zip client client.ovpn
#rm client.ovpn
mv client.ovpn /var/www/
wget -O /var/www/client.php "https://docs.google.com/uc?export=download&id=17ZnlinX_rk3Ht94jCf87MGOCvVEYBbOw"

# SSH Server Bypass
#rm /etc/ssh/sshd_custom 1>/dev/null 2>/dev/null
#cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
#cat /etc/ssh/sshd_config |grep -v -i allowusers |grep -v -i passwordauthen |grep -v -i uselogin |grep -v -i permitrootlogin |grep -v -i permittunnel >> /etc/ssh/sshd_custom
#rm /etc/ssh/sshd_config
#cp /etc/ssh/sshd_custom /etc/ssh/sshd_config
#sleep 1s
#echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
#echo "Port 143" >> /etc/ssh/sshd_config
#echo "Port 22" >> /etc/ssh/sshd_config
#echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#echo "PermitTunnel yes" >> /etc/ssh/sshd_config
#echo "UseDns no" >> /etc/ssh/sshd_config
#service ssh restart 1> /dev/null 2> /dev/null

# About
cd
clear
echo "Script WebMin Auto Install"
echo -e "\033[01;34m-----------------------------\033[0m"
echo -e "\033[01;31mInstall on 'Debian 7' Only \033[0m"
echo -e "\033[01;34m-----------------------------\033[0m"
echo "FaceBook Name : Palladium Actinium"
echo "FaceBook Url : https://www.facebook.com/100003964048764"
echo "Email : c3au@admin.in.th"
echo "-SSH Port 22,143"
echo "-VPN Port 1194"
echo "-Squid Proxy Port 8000,8080"
echo "TimeZone :  Bangkok"
echo "Traffic  :  http://$MYIP/"
echo "client.ovpn  :  http://$MYIP/client.php"
echo "Add User OpenVPN key: usernew"
echo -e "\033[01;34m-----------------------------\033[0m"
echo "root you password login web edit..."
sudo passwd root

#ใส่รหัสใหม่เข้าไป 2 ครั้ง จะได้ชื่อผู้ใช้ root รหัสผ่าน ??? ที่กำหนดใหม่
#เข้าสู่หน้าจัดการ http://You-IP-server:10000/
#เข้าไปที่หัวข้อ Server >> SSH Server >> Authentication
#ที่หัวข้อ Allow authentication by password? เลือกเป็น Yes กด Save และ Apply Changes
#SSH Port 22,143  Proxy Port 8080,3128
