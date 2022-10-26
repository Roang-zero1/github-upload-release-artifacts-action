#!/bin/bash

set -eu

set_tag() {
  if [ -n "${INPUT_CREATED_TAG}" ]; then
    TAG=${INPUT_CREATED_TAG}
  else
    TAG="$(echo "${GITHUB_REF}" | grep tags | grep -o "[^/]*$" || true)"
  fi
}

set_tag

if [ -z "$TAG" ]; then
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

HTTP_STATUS=$(echo "$HTTP_RESPONSE" | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

if [[ "$HTTP_STATUS" -ne 200 ]]; then
  echo "Release is missing"
  exit 1
fi

for path in "$@"; do
  if [[ -d "$path" ]]|| [[ -f "$path" ]]; then
    ghr -u "${GITHUB_REPOSITORY%/*}" -r "${GITHUB_REPOSITORY#*/}" "${GITHUB_REF#refs/tags/}" "${path}"
  else
    echo "Invalid path passed: ${path}"
    exit 1
  fi
done
