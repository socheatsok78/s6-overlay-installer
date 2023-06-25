# s6-overlay-installer
Installer scripts for s6-overlay

## Usage

The installer will automatically detect the architecture using `uname -m` of the container and download the appropriate archive.

```Dockerfile
ARG S6_OVERLAY_VERSION=v3.1.5.0
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/main/s6-overlay-installer-minimal.sh)"
ENTRYPOINT [ "/init" ]
```
