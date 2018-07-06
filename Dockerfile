FROM centos:7
LABEL maintainer="Nimbix, Inc."

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20180706.1130}

ARG GIT_BRANCH
ENV GIT_BRANCH ${GIT_BRANCH:-testlock}

RUN curl -H 'Cache-Control: no-cache' \
       https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
       | bash -s -- --setup-nimbix-desktop --setup-realvnc --image-common-branch $GIT_BRANCH

ADD NAE/AppDef.json /etc/NAE/AppDef.json

RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
