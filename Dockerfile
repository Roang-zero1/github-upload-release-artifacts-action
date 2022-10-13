FROM alpine:3.9 as base

RUN apk add --no-cache jq curl gcompat

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN curl -s https://api.github.com/repos/tcnksm/ghr/releases/latest | \
    jq -r '.assets[] | select(.browser_download_url | contains("linux_amd64"))  | .browser_download_url' | \
    xargs curl -o ghr.tgz -sSL && \
    mkdir -p ghr && \
    tar xzf ghr.tgz && \
    mv ghr_v*_linux_amd64/ghr /usr/local/bin && \
    rm -rf ghr*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
