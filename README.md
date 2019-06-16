# GitHub Action for GitHub Release upload

This action will upload a mod package created with [Roang-zero1/factorio-mod-package](https://github.com/Roang-zero1/factorio-mod-package) to the GitHub releases page.

## Usage

This action can be used with a repository contain a Factorio mod at base level.

The action can be used as follows:

```github-actions
action "Release on Github" {
  uses = "Roang-zero1/factorio-mod-release-github@main"
}
```

## Secrets

* `GITHUB_TOKEN` Provided by the GitHub action

## Acknowledgements

Idea based on [fnkr/github-action-ghr](https://github.com/fnkr/github-action-ghr)
