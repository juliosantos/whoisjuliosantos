#!/bin/bash

SCRIPT_LIST="lint deploy"
SCRIPT=$1

print_usage_and_exit() {
  echo >&2 "Usage: \`./run {lint|deploy}\`"
  exit 1
}

[[ "$#" -eq 1 ]] || print_usage_and_exit
[[ $SCRIPT_LIST =~ (^|[[:space:]])$1($|[[:space:]]) ]] || print_usage_and_exit

pushd "./scripts" >/dev/null || exit 1

./"$SCRIPT".sh

popd >/dev/null || exit 1
