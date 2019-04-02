#!/usr/bin/env bash

set -x

. /etc/JARVICE/jobenv.sh
. /etc/JARVICE/jobinfo.sh

env

exec /usr/bin/firefox
