#!/bin/bash
# set -ueo pipefail

echo "${BOLD}[$(basename "$0")] Building...${NORMAL}"

pushd .. 1>/dev/null

mkdir -p dist

rm -r dist/*

# mkdir -p tmp
#
# cp src/index.html dist/index.html
# sed -i -e "/^.*INJECT src\/fonts.css.*$/{r src/fonts.css" -e "d}" dist/index.html
#
# mogrify -format webp -quality 100 -path tmp/ src/julio.png
mogrify -format webp -quality 60 -path dist/ src/julio.png
# echo "data:image/webp;base64,$(cat tmp/julio.webp | base64)" > tmp/julio.webp.base64
# sed -i -e \
#   "/^.*INJECT src\/julio\.png.*$/{r tmp/julio.webp.base64" -e "d}" \
#   dist/index.html
#
# rm -r tmp/*
#
# e.g.:
# /* INJECT src/fonts.css */
# /* INJECT src/julio.png */

cp -r src/index.html dist/

popd 1>/dev/null || exit

echo >&2 "${BOLD}[$(basename "$0")] ...done.${NORMAL}"

exit 0
