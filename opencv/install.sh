#!/bin/sh

#
## Install dependencies
#
apt-get -y install libopencv-dev libgtk2.0-dev pkg-config
apt-get -y python-dev python-numpy libdc1394-22 libdc1394-22-dev
apt-get -y libjpeg-dev libpng12-dev libtiff4-dev libjasper-dev libavcodec-dev
apt-get -y libavformat-dev libswscale-dev libxine-dev libgstreamer0.10-dev
apt-get -y libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev
apt-get -y libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev
apt-get -y libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip

#
## Download OpenCV source
#
wget https://github.com/Itseez/opencv/archive/3.0.0.zip -O opencv-3.0.0
unzip -qq opencv-3.0.0.zip

#
## Build OpenCV
#
cd opencv-3.0.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_OPENGL=ON ..
make
make install
ldconfig
