FROM ubuntu:xenial
MAINTAINER Thomas Grosser <thomas.grosser@cloudogu.com>
ENV PANDOC_VERSION=1.19.2.1 \
    TEXLIVE_VERSION=2017

# copy texlive batch installation profile
COPY resources/texlive.profile .

# Install latex and other required packages
RUN set -x \
  && apt-get clean \
  && apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    tex-common \
    texinfo \
    equivs \
    perl-tk \
    perl-doc \
    make \
    git \
    ca-certificates \
    locales \
    zlibc \
    zlib1g-dev \
    haskell-platform \
    wget 

# install texlive
RUN set -x \
  && wget ftp://tug.org/historic/systems/texlive/${TEXLIVE_VERSION}/install-tl-unx.tar.gz \
  && tar xvf install-tl-unx.tar.gz \
  && cd install-tl-* \
  && ./install-tl -profile ../texlive.profile \
  && cd .. \
  && rm texlive.profile \
  && rm -R install-tl-* 

ENV PATH=/usr/local/texlive/${TEXLIVE_VERSION}/bin/x86_64-linux:$PATH

# Install Pandoc and required packages
RUN set -x \
  && cabal update \
  && cabal install --global \
  pandoc-${PANDOC_VERSION} \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pandoc-crossref

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["pandoc"]

CMD ["--help"]

