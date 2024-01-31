#!/usr/bin/env bash
set -ueo pipefail

bold=$(tput bold)
normal=$(tput sgr0)

function plan {
  sync false
}

function sync {
  AWS_COMMAND="aws s3 sync . s3://www.whoisjuliosantos.com/
    --delete
    --acl public-read
    --exclude \"deploy.sh\"
    --exclude \".git/*\""

  [[ $1 != true ]] && AWS_COMMAND="$AWS_COMMAND --dryrun"

  run_aws_command "$AWS_COMMAND"
}

function invalidate {
  run_aws_command "aws cloudfront create-invalidation
    --distribution-id E18YZMBAXAMT8Y
    --paths \"/index.html\""
}

function run_aws_command {
  echo >&2 "${bold}>${normal} $@"
  eval $@
}

function next_or_exit {
  echo
  read -p "${bold}$@ (y/n)${normal} " YN
  [[ $YN != y ]] && end || return 0
}

function end {
  [[ $# -gt 0 ]] && echo -e "\n${bold}$@${normal}"
  exit 0
}

[[ $(plan | tee /dev/tty) = "" ]] && end "Nothing to sync: stopping."

next_or_exit "Sync to S3?"
sync true

next_or_exit "Create Cloudfront invalidation for index.html?"
invalidate
