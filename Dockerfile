FROM debian:jessie
ENV MD5_SUM e4a65a755cf6ebdf7fc794935196a68b
ENV HEKAD_VERSION 0.9.0

RUN apt-get update -q && apt-get install -qy curl

RUN curl -OL https://github.com/mozilla-services/heka/releases/download/v${HEKAD_VERSION}/heka_${HEKAD_VERSION}_amd64.deb
RUN echo "${MD5_SUM}  heka_${HEKAD_VERSION}_amd64.deb" > hekad.md5 && md5sum --check hekad.md5
RUN dpkg -i heka_${HEKAD_VERSION}_amd64.deb
RUN mkdir /conf && echo "[DashboardOutput]" > /conf/hekad.toml
RUN apt-get remove --purge -y curl && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && rm ./heka_${HEKAD_VERSION}_amd64.deb

EXPOSE 4352
VOLUME ["/conf", "/var/cache/hekad"]


CMD ["hekad", "--config=/conf"]
