#!/bin/bash

# Install needed packages
apt-get -qq update && apt-get -qq -y install xz-utils git wget python3 python3-pip python-is-python3

# Install muxtools
pip3 install muxtools==0.3.0 muxtools-styx

# Add mediainfo repo
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-25_all.deb && dpkg -i repo-mediaarea_1.0-25_all.deb && apt-get -qq -y update && rm repo-mediaarea_1.0-25_all.deb

# Add mkvtoolnix repo
wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
echo "deb [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ jammy main\ndeb-src [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ jammy main" > /etc/apt/sources.list.d/mkvtoolnix.download.list

# Update repos and install mediainfo/mkvtoolnix
apt-get update && apt-get -y install mediainfo mkvtoolnix