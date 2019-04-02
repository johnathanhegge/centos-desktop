#!/usr/bin/env bash

. "$(dirname $0)/setenv.sh" "$1"

exec /usr/bin/firefox
