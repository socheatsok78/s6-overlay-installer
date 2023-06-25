#!/bin/sh
set -e

S6_DOWNLOAD_URL=https://github.com/just-containers/s6-overlay/releases/download
S6_TEMP=$(mktemp -d)
S6_ARCH=$(uname -m)
S6_OVERLAY_VERSION="${1:-$S6_OVERLAY_VERSION}"

if [ -z "${S6_OVERLAY_VERSION}" ]; then
	echo "[Error] S6_OVERLAY_VERSION is not set."
	exit 1
fi

s6_install () {
	echo "Downloading $1 archive..."
	curl -fSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/$1"
	echo

	echo "Verify $1 checksums..."
	curl -fSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/$1.sha256"
	sha256sum -c "$1.sha256"
	echo

	echo "Installing $1..."
	tar -C / -Jxpf "$1"
}

cd "${S6_TEMP}" && {
	s6_install "s6-overlay-noarch.tar.xz"
	s6_install "s6-overlay-${S6_ARCH}.tar.xz"
	s6_install "s6-overlay-symlinks-noarch.tar.xz"
	s6_install "s6-overlay-symlinks-arch.tar.xz"
	s6_install "s6-overlay-symlinks-arch.tar.xz"
}

echo "Cleaning up..."
cd -
rm -rf "${S6_TEMP}"
