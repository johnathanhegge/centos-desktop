FROM centos:7
LABEL maintainer="Nimbix, Inc."

ENV GIT_BRANCH testing
RUN curl -H 'Cache-Control: no-cache' \
       https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
       | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH
#RUN curl -H 'Cache-Control: no-cache' \
#        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
#        | bash -s -- --setup-nimbix-desktop

ADD NAE/AppDef.json /etc/NAE/AppDef.json

RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443