# This is jammy based. Somewhat important because we wanna support both arm64 and x86_64
FROM azul/zulu-openjdk:21.0.4-jre

ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Install muxtools
RUN apt-get -qq update && apt-get -qq -y install git wget python3 python3-pip python-is-python3
RUN pip3 install --user git+https://github.com/Vodes/muxtools-styx.git

# Install mediainfo
RUN wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-24_all.deb && dpkg -i repo-mediaarea_1.0-24_all.deb && apt-get update
RUN apt-get -y install mediainfo

# Install mkvtoolnix
RUN wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ jammy main" >> /etc/apt/sources.list.d/mkvtoolnix.download.list
RUN echo "\ndeb-src [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ jammy main" >> /etc/apt/sources.list.d/mkvtoolnix.download.list
RUN apt-get update && apt-get -y install mkvtoolnix