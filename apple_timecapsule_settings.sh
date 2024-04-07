
sudo apt-get install cifs-utils

sudo mkdir /media/timecapsule

sudo vim  /etc/fstab
//192.168.0.3/Mac4T /media/timecapsule  cifs  username=sheng,password=xxxx,uid=forsrc,auto,vers=1.0,iocharset=utf8,sec=ntlm,user    0 0
