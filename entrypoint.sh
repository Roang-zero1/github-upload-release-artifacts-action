#!/bin/sh

set -euo pipefail

TAG="$(echo ${GITHUB_REF} | grep tags | grep -o "[^/]*$" || true)"

if [ -z $TAG ]; then
  echo "This is not a tagged push." 1>&2
  exit 1
fi

# Prepare the headers
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

RELEASE_ID=$TAG

echo "Verifying release"
HTTP_RESPONSE=$(curl --write-out "HTTPSTATUS:%{http_code}" \
  -sSL \
  -H "${AUTH_HEADER}" \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${RELEASE_ID}")

if [ $HTTP_STATUS -ne 200 ]; then
  echo "Release is missing"
  exit 1
fi

RELEASE_DATA=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
echo $RELEASE_DATA | jq

echo $1
