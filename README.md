# docker-pandoc

A docker container with

* [pandoc](https://pandoc.org)
* [texlive](https://www.tug.org/texlive)

installed. It can be used to generate PDF from markdown.

## Build

`docker build -t cloudogu/pandoc`

## Usage

View all pandoc options with `docker run cloudogu/pandoc`.