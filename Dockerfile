# This is jammy based. Somewhat important because we wanna support both arm64 and x86_64
FROM azul/zulu-openjdk:21.0.4-jre

ARG TARGETPLATFORM
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# https://github.com/Vodes/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-nonfree.tar.xz

# Install everything else
RUN curl -fsSL https://raw.githubusercontent.com/Vodes/styx-baseimage/main/packages.sh | bash

# Install ffmpeg
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=linux64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=linuxarm64; else ARCHITECTURE=linux64; fi \
    && mkdir -p /opt/ffmpeg \
    && wget "https://github.com/Vodes/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-${ARCHITECTURE}-nonfree.tar.xz" \
    && tar -xvf "ffmpeg-master-latest-${ARCHITECTURE}-nonfree.tar.xz" -C /opt/ffmpeg --strip-components=1 \
    && chmod -R u+x /opt/ffmpeg/bin \
    && ln -s "/opt/ffmpeg/bin/ffmpeg" /usr/local/bin/ && ln -s "/opt/ffmpeg/bin/ffprobe" /usr/local/bin/