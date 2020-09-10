FROM phusion/baseimage:18.04-1.0.0

RUN cp -a /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i "s@http://.*archive.ubuntu.com@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list; \
    sed -i "s@http://.*security.ubuntu.com@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list;

# https://www.percona.com/doc/percona-xtrabackup/2.3/installation/apt_repo.html
# https://mirrors.tuna.tsinghua.edu.cn/percona/apt/percona-release_0.1-6.bionic_all.deb
COPY percona-release_0.1-6.bionic_all.deb /var/cache/

RUN dpkg -i /var/cache/percona-release_0.1-6.bionic_all.deb >> /dev/null 2>&1 || true;

RUN cp -a /etc/apt/sources.list.d/percona-release.list /etc/apt/sources.list.d/percona-release.list.bak; \
    sed -i "s@repo.percona.com@mirrors.tuna.tsinghua.edu.cn/percona@g" /etc/apt/sources.list.d/percona-release.list; \
    apt-get update;

RUN apt-get install -y --no-install-recommends percona-xtrabackup;

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

VOLUME /data

WORKDIR /data

CMD ["/sbin/my_init", "--", "bash", "-l"]
