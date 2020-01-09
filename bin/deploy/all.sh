#!/bin/bash
## =========================================================================
#   Deploy all components of Supplz VSF
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../" && pwd)}
DIR_CUR="$(cd "$(dirname "$0")" && pwd)"
# load local config and define common functions
. "${DIR_ROOT}/bin/lib/commons.sh"

/bin/bash "${DIR_CUR}/front.sh"
/bin/bash "${DIR_CUR}/api.sh"
/bin/bash "${DIR_CUR}/m2v.sh"
