FROM centos:7

ARG PROXY
ENV http_proxy=$PROXY \
    https_proxy=$PROXY \
    LANG=en_US.utf8 \
    LC_ALL=en_US.utf8

RUN yum install -y sudo

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/lib/systemd/systemd"]
