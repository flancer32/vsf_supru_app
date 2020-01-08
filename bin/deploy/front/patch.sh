#!/usr/bin/env/bash
## =========================================================================
#   Apply patches for 'vue-storefront'.
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../../" && pwd)}
# load local config and define common functions
. "${DIR_ROOT}/bin/commons.sh"

## =========================================================================
#   Setup & validate working environment
## =========================================================================
# check external vars used in this script (see cfg.[work|live].sh)

# local context vars
DIR_PATCH="${DIR_ROOT}/patch/front"

info "======================================================================"
info "Apply patches for 'vue-storefront' app."
info "======================================================================"

info "SUPPLZ-424: Fix 'ecosystem.json' for PM2."
patch -p0 <"${DIR_PATCH}/SUPPLZ-424.patch"

info "======================================================================"
info "All patches are applied for 'vue-storefront' app."
info "======================================================================"
