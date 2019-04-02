#!/usr/bin/env bash

set -x

. "$(dirname $0)/setenv.sh" "$1"

env

exec /usr/bin/firefox
