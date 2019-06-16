#!/bin/sh

set -euo pipefail

if [ "${GITHUB_REF}" == "${GITHUB_REF#refs/tags/}" ]; then
  echo "This is not a tagged push." 1>&2
  exit 78
fi

TAG="${GITHUB_REF#refs/tags/}"

# Prepare the headers
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

RELEASE_ID=$TAG

echo "Verifying release"
HTTP_RESPONSE=$(curl --write-out "HTTPSTATUS:%{http_code}" \
  -sSL \
  -H "${AUTH_HEADER}" \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${RELEASE_ID}")

HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

if [ $HTTP_STATUS -ne 200 ]; then
  echo "Release is missing"
  exit 1
fi

for path in "$@"; do
  if [[ -d $path || -f $path ]]; then
    ghr -u "${GITHUB_REPOSITORY%/*}" -r "${GITHUB_REPOSITORY#*/}" "${GITHUB_REF#refs/tags/}" "${path}"
  else
    echo "Invalid path passed"
    exit 1
  fi
done
