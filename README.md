# docker-pandoc
[![](https://images.microbadger.com/badges/image/cloudogu/pandoc.svg)](https://hub.docker.com/r/cloudogu/pandoc/)
[![](https://images.microbadger.com/badges/version/cloudogu/pandoc.svg)](https://hub.docker.com/r/cloudogu/pandoc/)

A docker container with

* [pandoc](https://pandoc.org)
* [texlive](https://www.tug.org/texlive)

installed. It can be used to generate PDF from markdown.

## Build

`docker build -t cloudogu/pandoc`

## Usage

View all pandoc options with `docker run cloudogu/pandoc`.
