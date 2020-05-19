FROM centos:7
LABEL maintainer="Nimbix, Inc."

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20200519.1030}

ARG GIT_BRANCH
#ENV GIT_BRANCH ${GIT_BRANCH:-centos7.7-test}
ENV GIT_BRANCH ${GIT_BRANCH:-master}

RUN yum -y install epel-release && \
    yum -y install firefox s3cmd

#RUN curl -H 'Cache-Control: no-cache' \
#    https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
#    | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH --skip-infiniband
RUN curl -H 'Cache-Control: no-cache' \
    https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
    | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH

COPY NAE/AppDef.json /etc/NAE/AppDef.json

RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
