#!/bin/bash
set -ueo pipefail

function plan {
  sync false
}

function sync {
  AWS_COMMAND="$(cat <<EOF
aws s3 sync ../dist/ s3://www.whoisjuliosantos.com/
  --delete
  --acl public-read
EOF
  )"

  [[ $1 != true ]] && AWS_COMMAND+="$(echo -e "\n  --dryrun")"

  run_aws_command "$AWS_COMMAND"
}

function invalidate {
  AWS_COMMAND="$(cat <<EOF
aws cloudfront create-invalidation
  --distribution-id E18YZMBAXAMT8Y
  --paths "/index.html"
EOF
  )"

  run_aws_command "$AWS_COMMAND"
}

function run_aws_command {
  echo >&2 "${BOLD}[$(basename "$0")] >${NORMAL} $*"
  eval "$(echo "$*" | tr "\n" " ")"
}

function next_or_exit {
  echo >&2 "${BOLD}[$(basename "$0")] ${NORMAL} $0..."

  read -rp "${BOLD}[$(basename "$0")] $* (y/n) ${NORMAL}" YN
  [[ $YN != y ]] && end || return 0
}

function end {
  [[ $# -gt 0 ]] && echo -e "\n${BOLD}[$(basename "$0")]$*${NORMAL}"
  exit 0
}

function main {
  echo "${BOLD}[$(basename "$0")] Planning...${NORMAL}"
  [[ "$(plan | tee /dev/tty)" = "" ]] && end "Nothing to sync: stopping."

  next_or_exit "Sync to S3?"
  sync true

  next_or_exit "Create Cloudfront invalidation for index.html?"
  invalidate

  echo >&2 "${BOLD}[$(basename "$0")] ...done.${NORMAL}"
}

main
