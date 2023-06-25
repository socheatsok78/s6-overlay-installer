# s6-overlay-installer
Installer scripts for s6-overlay

## Installer

### `s6-overlay-installer.sh`

This installer will install all default binaries and symlinks.

- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`
- `s6-overlay-symlinks-noarch.tar.xz`
- `s6-overlay-symlinks-arch.tar.xz`

### `s6-overlay-installer-minimal.sh`

This installer will install all default binaries.

- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`

### `s6-overlay-installer-syslogd.sh`

If you are running daemons that cannot log to stderr to take advantage of the s6 logging infrastructure, but hardcode the use of the old syslog() mechanism, you can extract this tarball, and your container will run a lightweight emulation of a syslogd daemon, so your syslog logs will be caught and stored to disk.


- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`
- `s6-overlay-symlinks-noarch.tar.xz`
- `s6-overlay-symlinks-arch.tar.xz`
- `syslogd-overlay-noarch.tar.xz`

## Usage

The installer will automatically detect the architecture using `uname -m` of the container and download the appropriate archive.

```Dockerfile
ARG S6_OVERLAY_VERSION=v3.1.5.0
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/main/s6-overlay-installer-minimal.sh)"
ENTRYPOINT [ "/init" ]
```
