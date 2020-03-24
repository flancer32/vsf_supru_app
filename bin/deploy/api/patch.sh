#!/bin/bash
## =========================================================================
#   Apply patches for 'vue-storefront-api'.
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../../" && pwd)}
# load local config and define common functions
. "${DIR_ROOT}/bin/lib/commons.sh"

## =========================================================================
#   Setup & validate working environment
## =========================================================================
# check external vars used in this script (see cfg.[work|live].sh)

# local context vars
DIR_PATCH="${DIR_ROOT}/patch/api"

info "======================================================================"
info "Apply patches for 'vue-storefront-api' app."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255

info "VSFSUPRU-35-1: Explicit data extraction from 'Error' objects."
patch -p0 <"${DIR_PATCH}/VSFSUPRU-35-1.patch"

info "VSFSUPRU-35-2: Improper usage of 'Error' constructor in './magento2/o2m.js'."
patch -p0 <"${DIR_PATCH}/VSFSUPRU-35-2.patch"

info "======================================================================"
info "All patches are applied for 'vue-storefront' app."
info "======================================================================"
