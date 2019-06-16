FROM alpine:3.9 as base

LABEL "com.github.actions.name"="GitHub Upload Release Artifacts"
LABEL "com.github.actions.description"="Upload Artifacts to a GitHub release."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="https://github.com/Roang-zero1/github-upload-release-artifacts"
LABEL "homepage"="https://github.com/Roang-zero1/github-upload-release-artifacts"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

RUN apk add --no-cache jq curl

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN curl -s https://api.github.com/repos/tcnksm/ghr/releases/latest | \
    jq -r '.assets[] | select(.browser_download_url | contains("linux_amd64"))  | .browser_download_url' | \
    xargs curl -o ghr.tgz -sSL && \
    mkdir -p ghr && \
    tar xzf ghr.tgz && \
    mv ghr_v*_linux_amd64/ghr /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
