#!/bin/sh
set -e

S6_TEMP=$(mktemp -d)
S6_ARCH=$(uname -m)

S6_OVERLAY_VERSION="${S6_OVERLAY_VERSION:1}"

if [[ -z "${S6_OVERLAY_VERSION}" ]]; then
	echo "[Error] S6_OVERLAY_VERSION is not set."
	exit 1
fi


s6_install () {
	echo "Downloading $1 archive..."
	curl -sLO "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/$1"
	curl -sLO "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/$1.sha256"

	echo "Verify $1 checksums..."
	sha256sum -c "$1.sha256"

	echo "Installing $1..."
	tar -C / -Jxpf "$1"
}

cd "${S6_TEMP}"
s6_install "s6-overlay-noarch.tar.xz"
s6_install "s6-overlay-${S6_ARCH}.tar.xz"

echo "Cleaning up..."
rm -rf "${S6_TEMP}"
