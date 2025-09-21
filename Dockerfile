# This is jammy based. Somewhat important because we wanna support both arm64 and x86_64
FROM azul/zulu-openjdk:21.0.8-jre

ARG TARGETPLATFORM
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# https://github.com/Vodes/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-nonfree.tar.xz
# https://github.com/Vodes/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-nonfree-7.1.tar.xz

# Install curl
RUN apt-get update && apt-get -y install curl unzip

# Add some common fonts
COPY common-fonts.zip .
RUN mkdir -p /usr/local/share/fonts && unzip -o common-fonts.zip -d /usr/local/share/fonts && rm common-fonts.zip

# Install everything else (not ffmpeg)
RUN curl -fsSL https://raw.githubusercontent.com/Vodes/styx-baseimage/main/packages.sh | bash

# Install ffmpeg
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=linux64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=linuxarm64; else ARCHITECTURE=linux64; fi \
    && mkdir -p /opt/ffmpeg \
    && wget "https://github.com/Vodes/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-${ARCHITECTURE}-nonfree-7.1.tar.xz" \
    && tar -xvf "ffmpeg-n7.1-latest-${ARCHITECTURE}-nonfree-7.1.tar.xz" -C /opt/ffmpeg --strip-components=1 \
    && rm -rf /opt/ffmpeg/doc && rm -f "ffmpeg-n7.1-latest-${ARCHITECTURE}-nonfree-7.1.tar.xz" && rm -f "/opt/ffmpeg/bin/ffplay" \
    && chmod -R u+x /opt/ffmpeg/bin \
    && ln -s "/opt/ffmpeg/bin/ffmpeg" /usr/local/bin/ && ln -s "/opt/ffmpeg/bin/ffprobe" /usr/local/bin/