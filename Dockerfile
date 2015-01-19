FROM debian:jessie
ENV MD5_SUM d23d0e599263b5111bf310fbea838ff3
ENV HEKAD_VERSION 0.8.3
ENV TARBALL_BASE heka-0_8_3-linux-amd64

RUN apt-get update -q && apt-get install -qy curl

RUN curl -OL https://github.com/mozilla-services/heka/releases/download/v${HEKAD_VERSION}/${TARBALL_BASE}.tar.gz
RUN echo "${MD5_SUM}  ${TARBALL_BASE}.tar.gz" > hekad.md5 && md5sum --check hekad.md5
RUN tar xvzf ${TARBALL_BASE}.tar.gz --strip-components=1 -C /usr
RUN mkdir /conf && echo "[DashboardOutput]" > /conf/hekad.toml
RUN apt-get remove --purge -y curl && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && rm ./${TARBALL_BASE}.tar.gz

EXPOSE 4352
VOLUME ["/conf", "/var/cache/hekad"]


CMD ["hekad", "--config=/conf"]
