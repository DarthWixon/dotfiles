#!/usr/bin/env bash
# Render every *.tmpl file in the repo, replacing {{name}} with the colour
# from everforest.ini, e.g. i3/theme.conf.tmpl -> i3/theme.conf.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$DIR")"
SRC="$DIR/everforest.ini"

# Turn `name = #hex` lines into sed substitutions: s/{{name}}/#hex/g
script=$(awk -F'[[:space:]]*=[[:space:]]*' '/^[a-z_0-9]+[[:space:]]*=/ { printf "s/{{%s}}/%s/g\n", $1, $2 }' "$SRC")

find "$ROOT" -name '*.tmpl' -not -path '*/.git/*' | while read -r tmpl; do
    out="${tmpl%.tmpl}"
    sed "$script" "$tmpl" > "$out"
    if grep -q '{{[a-z_0-9]*}}' "$out"; then
        echo "build.sh: unknown colour in $tmpl: $(grep -o '{{[a-z_0-9]*}}' "$out" | sort -u | tr '\n' ' ')" >&2
        exit 1
    fi
done
