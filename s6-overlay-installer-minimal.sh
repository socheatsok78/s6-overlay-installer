#!/bin/sh
set -e

S6_DOWNLOAD_URL=https://github.com/just-containers/s6-overlay/releases/download
S6_OVERLAY_VERSION="${1:-$S6_OVERLAY_VERSION}"
S6_OVERLAY_INSTALL_PATH="${2:-${S6_OVERLAY_INSTALL_PATH:-/}}"

if [ -z "${S6_OVERLAY_VERSION}" ]; then
	echo "[Error] S6_OVERLAY_VERSION is not set."
	exit 1
fi

s6_install () {
	local filename=$1

	echo "[-] Downloading ${filename} archive..."
	curl -fSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/${filename}"

	curl -fsSLO "$S6_DOWNLOAD_URL/${S6_OVERLAY_VERSION}/${filename}.sha256"
	echo -n "[-] Verify checksums "
	sha256sum -c "${filename}.sha256"

	echo -n "[-] Overlay ${filename} to ${S6_OVERLAY_INSTALL_PATH} directory: "
	mkdir -p "${S6_OVERLAY_INSTALL_PATH}"
	tar -C "${S6_OVERLAY_INSTALL_PATH}" -Jxpf "${filename}" && echo "OK"

	echo
}

S6_ARCH=$(uname -m)
if [[ "${S6_ARCH}" == "armv7l" ]]; then
	S6_ARCH=arm
fi
echo "Detecting architecture: ${S6_ARCH}"

S6_TEMP=$(mktemp -d)
echo "Creating temporary directory: ${S6_TEMP}"

cd "${S6_TEMP}" && {
	echo "Downloading modules..."
	s6_install "s6-overlay-noarch.tar.xz"
	s6_install "s6-overlay-${S6_ARCH}.tar.xz"
}

echo "Removing ${S6_TEMP}..."
cd -
rm -rf "${S6_TEMP}"
