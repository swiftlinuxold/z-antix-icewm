#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ ! $( id -u ) -eq 0 ]; then
	echo "You must be root to run this script."
	echo "Please enter su before running this script again."
	exit 2
fi

IS_CHROOT=0 # changed to 1 if and only if in chroot mode
USERNAME=""
DIR_DEVELOP=""

# The remastering process uses chroot mode.
# Check to see if this script is operating in chroot mode.
# /srv directory only exists in chroot mode
if [ -d "/srv" ]; then
	IS_CHROOT=1 # in chroot mode
	DIR_DEVELOP=/usr/local/bin/develop 
else
	USERNAME=$(logname) # not in chroot mode
	DIR_DEVELOP=/home/$USERNAME/develop 
fi



echo "Removing excess IceWM themes"
# Only default, icedesert, nice, nice2, win95, and yellowmotif remain.
# These themes are easy to read and easy on space.
# IceWM themes options are under Main menu -> Settings -> Themes
rm -r /usr/share/icewm/themes/AntiX-Blue
rm -r /usr/share/icewm/themes/AntiX-Green
rm -r /usr/share/icewm/themes/Antix-Pumpkin
rm -r /usr/share/icewm/themes/AntiX-Red
rm -r /usr/share/icewm/themes/blue-crystal
rm -r /usr/share/icewm/themes/eco-green
rm -r /usr/share/icewm/themes/FauxGlass
rm -r /usr/share/icewm/themes/Groove
rm -r /usr/share/icewm/themes/gtk
rm -r /usr/share/icewm/themes/gtk2
rm -r /usr/share/icewm/themes/IceClearlooks
rm -r /usr/share/icewm/themes/IceGilDust
rm -r /usr/share/icewm/themes/icegil-remix
rm -r /usr/share/icewm/themes/IceGnome2
rm -r /usr/share/icewm/themes/icenoir-3.3
rm -r /usr/share/icewm/themes/IceSoftBlue
rm -r /usr/share/icewm/themes/IceSoftBlue2
rm -r /usr/share/icewm/themes/IceTyrex
rm -r /usr/share/icewm/themes/Infadel2
rm -r /usr/share/icewm/themes/K-ath-Leen4
rm -r /usr/share/icewm/themes/Korstro
rm -r /usr/share/icewm/themes/KorstroDark
rm -r /usr/share/icewm/themes/metal2
rm -r /usr/share/icewm/themes/motif
rm -r /usr/share/icewm/themes/MurrinaCandied
rm -r /usr/share/icewm/themes/MurrinaCappuccino
rm -r /usr/share/icewm/themes/MurrinaEalm
rm -r /usr/share/icewm/themes/MurrinaGraphite
rm -r /usr/share/icewm/themes/NightShades*
rm -r /usr/share/icewm/themes/quiescent
rm -r /usr/share/icewm/themes/Simplest_black
rm -r /usr/share/icewm/themes/ThinSkin2
rm -r /usr/share/icewm/themes/Truth*
rm -r /usr/share/icewm/themes/UltraBlack
rm -r /usr/share/icewm/themes/warp3
rm -r /usr/share/icewm/themes/warp4

# IceWM menu changes:
# Remove deleted programs from the menu
# Add a link to the Swift Linux help page
# Add the installation option
echo "Changing the IceWM menu\n"

if [ $IS_CHROOT -eq 0 ]; then
	rm /home/$USERNAME/.icewm/menu
	cp $DIR_DEVELOP/icewm/dot_icewm/menu /home/$USERNAME/.icewm
	chown $USERNAME:users /home/$USERNAME/.icewm/menu
fi

rm /etc/skel/.icewm/menu
cp $DIR_DEVELOP/icewm/dot_icewm/menu /etc/skel/.icewm
if [ $IS_CHROOT -eq 0 ]; then
	chown $USERNAME:users /etc/skel/.icewm/menu
else
	chown demo:users /etc/skel/.icewm/menu
fi

rm /usr/share/antiX/localisation/en/icewm/menu-en
cp $DIR_DEVELOP/icewm/dot_icewm/menu /usr/share/antiX/localisation/en/icewm/menu-en
chown root:root /usr/share/antiX/localisation/en/icewm/menu-en

echo "Changing the IceWM theme\n"

if [ $IS_CHROOT -eq 0 ]; then
	rm /home/$USERNAME/.icewm/theme
	cp $DIR_DEVELOP/icewm/dot_icewm/theme /home/$USERNAME/.icewm
	chown $USERNAME:users /home/$USERNAME/.icewm/theme
fi

rm /etc/skel/.icewm/theme
cp $DIR_DEVELOP/icewm/dot_icewm/theme /etc/skel/.icewm
if [ $IS_CHROOT -eq 0 ]; then
	chown $USERNAME:users  /etc/skel/.icewm/theme
else
	chown demo:users /etc/skel/.icewm/theme
fi

echo "Changing the IceWM startup file\n"

if [ $IS_CHROOT -eq 0 ]; then
	rm /home/$USERNAME/.icewm/startup
	cp $DIR_DEVELOP/icewm/dot_icewm/startup-diet /home/$USERNAME/.icewm/startup
	chmod a+x /home/$USERNAME/.icewm/startup
	chown $USERNAME:users /home/$USERNAME/.icewm/startup
fi

rm /etc/skel/.icewm/startup
cp $DIR_DEVELOP/icewm/dot_icewm/startup-diet /etc/skel/.icewm/startup
chmod a+x /etc/skel/.icewm/startup
if [ $IS_CHROOT -eq 0 ]; then
	chown $USERNAME:users /etc/skel/.icewm/startup
else
	chown demo:users /etc/skel/.icewm/startup
fi

echo "Changing .xinitrc"

if [ $IS_CHROOT -eq 0 ]; then
	rm /home/$USERNAME/.xinitrc
	cp $DIR_DEVELOP/icewm/user/xinitrc-diet /home/$USERNAME/.xinitrc
	chown $USERNAME:users /home/$USERNAME/.xinitrc
fi

rm /etc/skel/.xinitrc
cp $DIR_DEVELOP/icewm/user/xinitrc-diet /etc/skel/.xinitrc
if [ $IS_CHROOT -eq 0 ]; then
	chown $USERNAME:users /etc/skel/.xinitrc
else
	chown demo:users /etc/skel/.xinitrc
fi

exit 0
