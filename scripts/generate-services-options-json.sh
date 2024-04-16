#!/usr/bin/env bash

cd "$(dirname "$0")"

repo="NixOS/nixpkgs"
branch="release-23.11"

commit_sha=$(curl -s "https://api.github.com/repos/$repo/commits/$branch" | jq -r '.sha')
tarball_url="https://api.github.com/repos/$repo/tarball/$commit_sha"

nix eval \
    --json \
    -f ../nix/flake_info_services.nix \
    -I nixpkgs=$tarball_url \
    nixos-options
