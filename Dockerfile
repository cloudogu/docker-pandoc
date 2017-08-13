FROM ubuntu:xenial
MAINTAINER Thomas Grosser <thomas.grosser@cloudogu.com>
ENV DEBIAN_FRONTEND noninteractive
ENV PANDOC_VERSION "1.19.2.1"

# Install latex and other required packages
RUN set -x \
  && apt-get clean \
  && apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-full \
    fontconfig \
    lmodern \
    make \
    git \
    ca-certificates \
    locales \
    zlibc \
    zlib1g-dev \
    haskell-platform  \
    curl

# Install Pandoc and required packages
RUN set -x \
  && cabal update \
  && cabal install \
  pandoc-$PANDOC_VERSION \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pandoc-crossref

# Install PlantUML filter
# TODO

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]