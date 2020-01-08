#!/usr/bin/env/bash
## =========================================================================
#   Deploy all components of Supplz VSF
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../" && pwd)}
# load local config and define common functions
/bin/bash "${DIR_ROOT}/bin/lib/commons.sh"

## =========================================================================
#   Setup & validate working environment
## =========================================================================
# check external vars used in this script (see cfg.[work|live].sh)
#: "${DEPLOY_MODE:?}"
# local context vars
DIR_DEPLOY="${DIR_ROOT}/bin/deploy"

/bin/bash "${DIR_DEPLOY}/front.sh"
/bin/bash "${DIR_DEPLOY}/api.sh"
/bin/bash "${DIR_DEPLOY}/m2v.sh"