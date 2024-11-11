> [!IMPORTANT]
> DEPRECATED: Please use [socheatsok78/s6-overlay-distribution](https://github.com/socheatsok78/s6-overlay-distribution) instead.

# s6-overlay-installer

Installer scripts for [s6-overlay](https://github.com/just-containers/s6-overlay).

A container image distribution of the s6-overlay can be found [here](https://github.com/socheatsok78/s6-overlay-distribution).

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

You probably might also want to set `S6_BEHAVIOUR_IF_STAGE2_FAILS=2`, the `S6_BEHAVIOUR_IF_STAGE2_FAILS` use to determines what the container should do if one of the service scripts fails. In this case since we are not using `CMD` instruction, the service will keep on restarting if it failed but the container will continue to keep running as like nothing happends.

By setting the `S6_BEHAVIOUR_IF_STAGE2_FAILS=2`, we instruction the supervisor to stop the container if any of the service failed. Combined it with Docker `restart-policy` the container will act like it used to be.

## Installer

Available installers:

### `s6-overlay-installer.sh`

This installer will install all default binaries and symlinks.

- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`
- `s6-overlay-symlinks-noarch.tar.xz`
- `s6-overlay-symlinks-arch.tar.xz`

### `s6-overlay-installer-minimal.sh`

This installer will install only necessary binaries.

- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`

### `s6-overlay-installer-syslogd.sh`

If you are running daemons that cannot log to stderr to take advantage of the s6 logging infrastructure, but hardcode the use of the old syslog() mechanism, you can extract this tarball, and your container will run a lightweight emulation of a syslogd daemon, so your syslog logs will be caught and stored to disk.


- `s6-overlay-noarch.tar.xz`
- `s6-overlay-${S6_ARCH}.tar.xz`
- `s6-overlay-symlinks-noarch.tar.xz`
- `s6-overlay-symlinks-arch.tar.xz`
- `syslogd-overlay-noarch.tar.xz`
