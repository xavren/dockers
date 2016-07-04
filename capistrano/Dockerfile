FROM centos:7

RUN yum install -y centos-release-scl && \
    yum-config-manager -y --enable rhel-server-rhscl-7-rpms && \
    yum install -y rh-ruby23 git

COPY install.sh /tmp
RUN /tmp/install.sh

COPY entrypoint.sh /

WORKDIR /srv
ENTRYPOINT ["/entrypoint.sh"]