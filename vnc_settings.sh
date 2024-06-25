#Enable the VNC server to start each time you log in
#If you have a Jetson Nano 2GB Developer Kit (running LXDE)

mkdir -p ~/.config/autostart
cp /usr/share/applications/vino-server.desktop ~/.config/autostart/.

#For all other Jetson developer kits (running GNOME)
cd /usr/lib/systemd/user/graphical-session.target.wants
sudo ln -s ../vino-server.service ./.

#Configure the VNC server
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false

#Set a password to access the VNC server
# Replace thepassword with your desired password
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino vnc-password $(echo -n 'abc123'|base64)

#Reboot the system so that the settings take effect
sudo reboot
