FROM ubuntu:latest

RUN apt-get update

#install locals
RUN apt-get install -y --no-install-recommends locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

#install isolate
RUN apt-get install -y --no-install-recommends ca-certificates git libcap-dev make gcc g++ && \
    git clone https://github.com/judge0/isolate.git /tmp/isolate && \
    cd /tmp/isolate && \
    git checkout ad39cc4d0fbb577fb545910095c9da5ef8fc9a1a && \
    make -j$(nproc) install && \
    rm -rf /tmp/*

ENV SANDBOX_ROOT /var/local/lib/isolate