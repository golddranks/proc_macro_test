FROM debian:jessie
MAINTAINER Pyry Kontio <pyry.kontio@drasa.eu>
USER root

RUN apt-get update && \
  apt-get install -y \
  curl \
  g++ \
  git \
  ca-certificates \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /workdir

WORKDIR /workdir

ENV PATH=/root/.cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2017-02-13 && \
    rustup target add x86_64-unknown-linux-musl

ADD . /workdir

RUN cargo build --target=x86_64-unknown-linux-musl

CMD /bin/bash
