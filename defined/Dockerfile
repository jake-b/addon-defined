ARG BUILD_FROM=ghcr.io/hassio-addons/base/aarch64:12.2.7

FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install iptables
RUN \
    apk add --no-cache \
        iptables=1.8.8-r1 \
    \
    && cd /usr/bin \
    && curl -O https://dl.defined.net/02c6d0f9/v0.1.9/linux/arm64/dnclient \
    && chmod +x dnclient \
    && curl -L https://github.com/snail007/goproxy/releases/download/v13.1/proxy-linux-arm64-v8.tar.gz | tar xvfz - proxy

COPY rootfs /
