#!/bin/sh

cd /tmp

echo Download s6-overlay...
curl -sLO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz
curl -sLO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz.sha256
curl -sLO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz
curl -sLO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz.sha256

echo Verify checksums...
sha256sum -c *.sha256

echo Install s6-overlay...
tar -C / -Jxpf s6-overlay-noarch.tar.xz
tar -C / -Jxpf s6-overlay-x86_64.tar.xz

rm -rf /tmp/*.tar*
