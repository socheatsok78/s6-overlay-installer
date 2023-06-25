FROM alpine

RUN apk add --no-cache \
	bash \
	curl


ARG S6_OVERLAY_VERSION=3.1.5.0

COPY --chmod=0765 ./s6-overlay-installer-minimal.sh /s6-overlay-installer-minimal.sh
RUN /s6-overlay-installer-minimal.sh

COPY --chmod=0765 ./s6-overlay-installer-full.sh /s6-overlay-installer-full.sh
RUN /s6-overlay-installer-full.sh

ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]
