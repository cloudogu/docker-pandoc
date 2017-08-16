# docker-pandoc

A docker container with

* [pandoc]()
* [texlive]()
* [plantuml]()
* [pandoc-plantuml-filter]()

installed. It can be used to generate PDF from markdown.

## Build
`docker build -t cloudogu/pandoc`

## Usage
View all pandoc options with `docker run cloudogu/pandoc`. An example for usage can be found here [pandoc_example](https://github.com/cloudogu/pandoc_example).



