FROM ubuntu:xenial
MAINTAINER Thomas Grosser <thomas.grosser@cloudogu.com>
ENV PANDOC_VERSION=1.19.2.1 \
    TEXLIVE_VERSION=2018 \
    PLANTUML_URL=https://ecosystem.cloudogu.com/plantuml

# copy texlive batch installation profile
COPY resources/texlive.profile .

# Install latex, PlantUML filter and other required packages
# we need ghostscript in order to convert eps images
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
    wget \
    curl \
    ghostscript

# Install texlive
RUN set -x \
  && wget ftp://tug.org/historic/systems/texlive/${TEXLIVE_VERSION}/install-tl-unx.tar.gz \
  && tar xvf install-tl-unx.tar.gz \
  && cd install-tl-* \
  && ./install-tl -profile ../texlive.profile \
  && cd .. \
  && rm texlive.profile \
  && rm -R install-tl-* 

# installed texlive version is 2018, but the path uses still 2017
ENV PATH=/usr/local/texlive/2017/bin/x86_64-linux:$PATH

# Update the default font map files
RUN updmap -sys

# Install Pandoc and required packages
RUN set -x \
  && cabal update \
  && cabal install --global \
  pandoc-${PANDOC_VERSION} \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pandoc-crossref

# Install PlantUML filter
RUN set -x \
  && git clone https://github.com/cloudogu/pandoc-plantuml-filter.git \
  && cd pandoc-plantuml-filter/ \
  && cabal install --global

# copy plantuml script and make it executable
COPY resources/plantuml /pandoc-plantuml-filter/scripts/
RUN set -x \
  && chmod +x /pandoc-plantuml-filter/scripts/plantuml

ENV PATH=/pandoc-plantuml-filter/scripts:$PATH

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["pandoc"]

CMD ["--help"]

