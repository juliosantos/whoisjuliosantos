#!/bin/bash
# set -ueo pipefail

echo >&2 "${BOLD}[$(basename "$0")] Linting...${NORMAL}"

LINT_COMMAND="shellcheck $(echo *.sh)"

echo >&2 "${BOLD}[$(basename "$0")] >${NORMAL} $LINT_COMMAND"

$LINT_COMMAND

echo >&2 "${BOLD}[$(basename "$0")] ...done.${NORMAL}"
