# syntax=docker/dockerfile:1

ARG UV_VERSION=0.12.19
FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv

FROM bellsoft/liberica-runtime-container:jre-21-glibc
ARG PYTHON_VERSION=3.14
ARG MUXTOOLS_VERSION=0.5.0b1
ARG MUXTOOLS_STYX_VERSION=0.3.0b1
ARG MUXTOOLS_BINARIES_PACKAGES="mkvtoolnix==102.0,flac==1.5.0.post2,ffmpeg==9.0.2-r2"

RUN apk add --no-cache \
    bash \
    ca-certificates \
    coreutils \
    curl \
    fontconfig \
    git \
    libgcc \
    libstdc++ \
    unzip

COPY --from=uv /uv /uvx /usr/local/bin/

ENV UV_PYTHON_INSTALL_DIR=/opt/python \
    UV_PYTHON_BIN_DIR=/usr/local/bin \
    VIRTUAL_ENV=/opt/venv \
    PATH="/opt/venv/bin:${PATH}"

RUN uv python install "${PYTHON_VERSION}" --default \
    && uv venv "${VIRTUAL_ENV}" --python /usr/local/bin/python \
    && uv pip install \
        --python "${VIRTUAL_ENV}/bin/python" \
        muxtools==${MUXTOOLS_VERSION} \
        muxtools-styx==${MUXTOOLS_STYX_VERSION}

COPY common-fonts.zip /tmp/common-fonts.zip

RUN mkdir -p /usr/local/share/fonts \
    && unzip -q /tmp/common-fonts.zip -d /usr/local/share/fonts \
    && rm /tmp/common-fonts.zip \
    && fc-cache -f

ENV MUXTOOLS_BINARIES_GLOBAL_PATH=/opt/muxtools/bin \
    MUXTOOLS_BINARIES_MANAGED_GLOBAL=1 \
    MUXTOOLS_BINARIES_PACKAGES=${MUXTOOLS_BINARIES_PACKAGES}

RUN muxtools binaries sync
