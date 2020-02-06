#!/bin/bash
set -eu
cd $(dirname "$0")


mosquitto_pub -t "cmnd/mark/thermostat/query" -m ""

# Refresh everything in the configs that has stat/.*/POWER
# grep will return an error code cause grep can't read some files so no pipefail for this script
grep -rohs --exclude=\*.{db,sh,swp} --exclude-dir=.git "stat\/.*\/POWER" | sed 's/^stat/cmnd/' | xargs -I {} mosquitto_pub -t "{}" -m ""
