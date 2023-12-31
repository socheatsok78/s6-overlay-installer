#!/bin/sh
set -e

S6_DOWNLOAD_URL=https://github.com/just-containers/s6-overlay/releases/download
S6_OVERLAY_VERSION="${1:-$S6_OVERLAY_VERSION}"

if [ -z "${S6_OVERLAY_VERSION}" ]; then
	echo "[Error] S6_OVERLAY_VERSION is not set."
	exit 1
fi

s6_install () {
	echo "[-] Downloading $1 archive..."
	curl -fSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/$1"

	curl -fsSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/$1.sha256"
	echo -n "[-] Verify checksums "
	sha256sum -c "$1.sha256"

	echo -n "[-] Overlay $1 to rootfs directory: "
	tar -C / -Jxpf "$1" && echo "OK"

	echo
}

S6_ARCH=$(uname -m)
echo "Detecting architecture: ${S6_ARCH}"

S6_TEMP=$(mktemp -d)
echo "Creating temporary directory: ${S6_TEMP}"

cd "${S6_TEMP}" && {
	echo
	echo "Downloading modules..."
	s6_install "s6-overlay-noarch.tar.xz"
	s6_install "s6-overlay-${S6_ARCH}.tar.xz"
	s6_install "s6-overlay-symlinks-noarch.tar.xz"
	s6_install "s6-overlay-symlinks-arch.tar.xz"
	echo
}

echo "Removing ${S6_TEMP}..."
cd -
rm -rf "${S6_TEMP}"
