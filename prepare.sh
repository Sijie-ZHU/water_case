#!/usr/bin/env bash
set -euo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
target=${1:-"$root/run"}
if [[ -e "$target" || -L "$target" ]]; then
    echo "运行目录已存在，请指定一个新目录：$target" >&2
    exit 1
fi
scratch=$(mktemp -d -- "$(dirname -- "$target")/.nanjing-prepare.XXXXXX")
cp -a -- "$root/case/." "$scratch/"
for archive in "$root"/inputs/*.tar.xz.parts; do
    cat "$archive"/part-*.xzpart | tar -xJf - -C "$scratch"
done
for rank in {0..7}; do
    test -s "$scratch/processor$rank/0/air/T"
    test -s "$scratch/processor$rank/constant/vegetation/solarLoadFineFaces"
done
touch "$scratch/nanjing-river.foam"
mv -Tn -- "$scratch" "$target"
[[ ! -e "$scratch" ]]
printf '算例已准备好：%s\n' "$target"
