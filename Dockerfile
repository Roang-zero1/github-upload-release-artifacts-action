FROM roangzero1/factorio-mod:luarocks5.3-alpine as base

LABEL "com.github.actions.name"="Factorio Mod luacheck"
LABEL "com.github.actions.description"="Run a Factorio mod through luacheck"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
