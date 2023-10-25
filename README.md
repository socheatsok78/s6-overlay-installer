# s6-overlay-installer

Installer scripts for s6-overlay

https://github.com/just-containers/s6-overlay

## Usage

The installer will automatically detect the architecture using `uname -m` of the container and download the appropriate archive.

```Dockerfile
# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.5.0
ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer-minimal.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"
ENTRYPOINT [ "/init" ]
```

If you are not planning to use `CMD` instruction to run your application and instead uses the `s6` supervised service. You might find it useful to add this in place of your `CMD` instruction.

```Dockerfile
CMD [ "sleep", "infinity" ]
```

## Installer

Available installers:

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
