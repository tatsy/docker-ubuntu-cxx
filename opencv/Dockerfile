#
# Dockerfile for building C++ project with OpenCV
#
# https://github.com/tatsy/dockerfile/ubuntu/cxx
#

# Base image
FROM tatsy/ubuntu-cxx:default

# Install OpenCV
#!/bin/sh

#
## Install dependencies
#
RUN \
  apt-add-repository multiverse && \
  apt-get update -qq && \
  apt-get upgrade -qq && \
  apt-get -y install libopencv-dev libgtk2.0-dev pkg-config \
             python-dev python-numpy libdc1394-22 libdc1394-22-dev \
             libjpeg-dev libpng12-dev libtiff4-dev libjasper-dev libavcodec-dev \
             libavformat-dev libswscale-dev libxine-dev libgstreamer0.10-dev \
             libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev \
             libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev \
             libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip

#
## Download OpenCV source
#
RUN wget https://github.com/Itseez/opencv/archive/3.0.0.zip -O opencv-3.0.0.zip
RUN unzip -qq opencv-3.0.0.zip

#
## Build OpenCV
#
RUN \
  cd opencv-3.0.0 && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_OPENGL=ON .. && \
  make -j4 && \
  make install && \
  ldconfig

#
## Clear working directory
#
RUN rm -rf opencv-3.0.0
RUN rm opencv-3.0.0.zip
