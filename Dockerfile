FROM alpine

RUN apk add --no-cache \
	bash \
	curl

ARG S6_OVERLAY_VERSION=3.1.5.0

ARG S6_OVERLAY_VERSION=v3.1.5.0
ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer.sh
# ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer-minimal.sh
# ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer-syslogd.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"

ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]
