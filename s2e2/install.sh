#!/usr/bin/env bash
set -ex

git clone https://github.com/xDiaym/asm-template.git $1
find $1 -not -path ".git/*" -not -path './build_*' -type f | xargs sed -i "s/s2e2/${1}/g"
