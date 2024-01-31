#!/usr/bin/env bash

FORCE=$1

function sync {
  COMMAND="aws s3 sync --delete --acl public-read --exclude \".git/*\" . s3://www.whoisjuliosantos.com/"

  if [ $1 != true ]; then
    COMMAND="$COMMAND --dryrun"
  fi

  echo "Executing: $COMMAND"
  eval $COMMAND
}

function invalidate {
  COMMAND="aws cloudfront create-invalidation --distribution-id E18YZMBAXAMT8Y --paths \"/index.html\""

  echo "Executing: $COMMAND"
  eval $COMMAND
}

sync false

read -p "Sync to S3? (y/n) " YN1
if [ "$YN1" != y ]; then exit; fi

sync true

read -p "Create Cloudfront invalidation for index.html? (y/n) " YN2
if [ "$YN2" != y ]; then exit; fi

invalidate
