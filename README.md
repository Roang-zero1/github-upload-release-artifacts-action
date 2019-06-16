# GitHub Action for Uploading Release Artifacts

This action will upload all paths passed as arguments as artifacts to an existing release.
This action should be triggered with a tag after a release for this tag has been created.

Arguments can either be file or directory paths, for directories all contained files will be uploaded.

## Usage

A sample workflow would be:

```github-actions
workflow "Check & Release" {
  on = "push"
  resolves = ["Upload artifacts"]

  action "Build" {
    uses = [./]
  }

  action "Create GitHub release" {
    uses = "Roang-zero1/github-create-release-action@master"
    needs = ["Build"]
    secrets = [
      "GITHUB_TOKEN"
    ]
  }


  action "Upload artifacts" {
    uses = "Roang-zero1/github-upload-release-artifacts-action@master"
    args = [ "dist/bin/", "dist/shell/compiled.sh"]
    needs = ["Create GitHub release"]
    secrets = [
      "GITHUB_TOKEN"
    ]
  }
}
```

## Secrets

* `GITHUB_TOKEN` Provided by the GitHub action

## Acknowledgements

Idea based on [fnkr/github-action-ghr](https://github.com/fnkr/github-action-ghr)
