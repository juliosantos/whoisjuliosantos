#!/bin/bash
# set -ueo pipefail

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
export BOLD NORMAL

print_usage_and_exit() {
  echo >&2 "Usage: \`./run {dev|build|lint|deploy}\`"
  exit 1
}

SCRIPT=$1

[[ "dev build lint deploy" =~ (^|[[:space:]])$SCRIPT($|[[:space:]]) ]] || print_usage_and_exit

pushd "./scripts" 1>/dev/null || exit 1

eval "./$SCRIPT.sh"

popd 1>/dev/null || exit

exit 0
