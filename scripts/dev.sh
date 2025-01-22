#!/bin/bash
# set -ueo pipefail

pushd .. 1>/dev/null

./run build

echo >&2 "${BOLD}[$(basename "$0")] Starting server${NORMAL} on http://localhost:8000..."

python -m http.server -d dist &
python_pid=$!

open "http://localhost:8000"

dir_to_watch="src/"

find $dir_to_watch -type f | entr -p sh -c "./run build; osascript -e 'tell application \"Google Chrome\" to reload (tabs of window 1 whose URL contains \"localhost:8000\")'"

kill -9 $python_pid

popd 1>/dev/null || exit

exit 0
