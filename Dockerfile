FROM alpine

RUN apk add --no-cache \
	bash \
	curl

COPY --chmod=0765 ./s6-overlay-installer-minimal.sh /s6-overlay-installer-minimal.sh

ARG S6_OVERLAY_VERSION=3.1.5.0
RUN /s6-overlay-installer-minimal.sh

ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]
