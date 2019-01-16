#!/bin/bash
set -euo pipefail

# PLANTUML_SERVER is not defined, use PLANTUML_URL which is defined in Dockerfile
if [ -z ${PLANTUML_SERVER+x} ]; then
  if [ -z ${PLANTUML_URL+x} ]; then
    echo "no plantuml url available"
    exit 1
  fi

  PLANTUML_SERVER="${PLANTUML_URL}"
fi

# strip /plantuml ending, because PLANTUML_URL in Dockerfile is defined with this extension
# but we need the url without /plantuml
if [[ "${PLANTUML_SERVER}" == */plantuml ]]; then
  PLANTUML_SERVER="${PLANTUML_SERVER//\/plantuml/}"
fi

# define PUML
PUML=""

# read plantuml syntax from stdin and respect the last line
while read line || [ -n "${line}" ]; do PUML=${PUML}$'\n'${line} ; done

# remove leading whitespace characters
PUML="${PUML#"${PUML%%[![:space:]]*}"}"
# remove trailing whitespace characters
PUML="${PUML%"${PUML##*[![:space:]]}"}"

# add @startuml tag if it is missing in the input
if [[ "${PUML}" != @startuml* ]]; then
   PUML=@startuml$'\n'${PUML}
fi

# append @enduml tag if it is missing in the input
if [[ "${PUML}" != *@enduml ]]; then
   PUML=${PUML}$'\n'"@enduml"
fi

# encode plantuml syntax into image URL
IMGURL=$(curl --silent ${PLANTUML_SERVER}/plantuml/form -d text="${PUML}" -v 2>&1 | grep Location | awk '{print $NF}' | sed 's/\/uml\//\/eps\//') 

# remove trailing linefeed
IMGURL=${PLANTUML_SERVER}${IMGURL%$'\r'} 

# get UML image from server
curl --silent ${IMGURL}

