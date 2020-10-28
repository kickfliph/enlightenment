#!/bin/bash

sudo aptitude install cmake ninja-build gcc g++ check libssl-dev libsystemd-dev libjpeg-dev libglib2.0-dev libgstreamer1.0-dev libluajit-5.1-dev libfreetype6-dev libfontconfig1-dev libfribidi-dev libx11-dev libxext-dev libxrender-dev libgl1-mesa-dev libgif-dev libtiff5-dev libwebp-dev libopenjp2-7-dev libpoppler-dev libpoppler-cpp-dev libspectre-dev libraw-dev librsvg2-dev libharfbuzz-dev libscim-dev libudev-dev libmount-dev libdbus-1-dev libpulse-dev libsndfile1-dev libxcursor-dev libxcomposite-dev libxinerama-dev libxrandr-dev libxtst-dev libxss-dev libbullet-dev libpam0g-dev libgstreamer-plugins-base1.0-dev libcurl4-openssl-dev doxygen libinput-dev intltool libfile-fnmatch-perl bluez-firmware python3-bluez python-bluez python3-pyalsa python-pyalsa bluez-tools alsa-tools acpid rfkill -y

sudo mkdir /opt/e
cd /opt/e
sudo git clone https://git.enlightenment.org/core/efl.git
sudo git clone https://git.enlightenment.org/core/enlightenment.git
sudo git clone https://git.enlightenment.org/apps/terminology.git
sudo git clone https://git.enlightenment.org/apps/rage.git

sudo export PATH=/usr/local/bin:"$PATH"
sudo export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:"$PKG_CONFIG_PATH"
sudo export LD_LIBRARY_PATH=/usr/local/lib:"$LD_LIBRARY_PATH"
sudo export CFLAGS="-O3 -ffast-math -march=native"

sudo aptitude install python3 python3-pip python3-setuptools python3-wheel ninja-build -y
sudo git clone https://github.com/mesonbuild/meson.git

for i in efl enlightenment terminology rage
do
 cd $i
 /opt/e/meson/meson.py build
 ninja -C build
 sudo ninja -C build install
 sudo ldconfig	
 cd ..
done 

sudo cp /opt/enlightenment/exsession.desktop /usr/share/xsessions/
sudo /etc/init.d/lightdm restart


