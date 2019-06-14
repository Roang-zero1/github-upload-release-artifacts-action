FROM roangzero1/factorio-mod:luarocks5.3-alpine as base

LABEL "com.github.actions.name"="Factorio Mod GitHub release"
LABEL "com.github.actions.description"="Upload a Factorio mod to the GitHub releases"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="white"

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
