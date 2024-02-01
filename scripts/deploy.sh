#!/bin/bash
set -ueo pipefail

bold=$(tput bold)
normal=$(tput sgr0)

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
  echo >&2 "${bold}>${normal} $*"
  eval "$(echo "$*" | tr "\n" " ")"
}

function next_or_exit {
  echo
  read -rp "${bold}$* (y/n) ${normal}" YN
  [[ $YN != y ]] && end || return 0
}

function end {
  [[ $# -gt 0 ]] && echo -e "\n${bold}$*${normal}"
  exit 0
}

function main {
  echo "${bold}Planning...${normal}"
  [[ "$(plan | tee /dev/tty)" = "" ]] && end "Nothing to sync: stopping."

  next_or_exit "Sync to S3?"
  sync true

  next_or_exit "Create Cloudfront invalidation for index.html?"
  invalidate
}

main
