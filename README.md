# GitHub Action for Uploading Release Artifacts

This action will upload all paths passed as arguments as artifacts to an existing release.
This action should be triggered with a tag after a release for this tag has been created.

Arguments can either be file or directory paths, for directories all contained files will be uploaded.

## Usage

A sample workflow would be:

```yaml
on: push
name: Build & Release
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: build
      run: |
        ./build.sh
  release:
    runs-on: ubuntu-latest
    needs: [build]
    steps:
    - uses: actions/checkout@master
    - name: Create release
      uses: Roang-zero1/github-create-release-action@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    - name: Upload release artifacts
      uses: Roang-zero1/github-upload-release-artifacts-action@v2
      with:
        args: "dist/bin/ dist/shell/compiled.sh"
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Secrets

* `GITHUB_TOKEN` Provided by the GitHub action

## Acknowledgments

Idea based on [fnkr/github-action-ghr](https://github.com/fnkr/github-action-ghr)
