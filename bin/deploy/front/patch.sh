#!/bin/bash
## =========================================================================
#   Apply patches for 'vue-storefront'.
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
DIR_PATCH="${DIR_ROOT}/patch/front"

info "======================================================================"
info "Apply patches for 'vue-storefront' app."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255

info "VSFSUPRU-27: Fix attribute query for Elasticsearch >6.0."
patch -p0 <"${DIR_PATCH}/VSFSUPRU-27.patch"

info "VSFSUPRU-34: Disable 'payment-cash-on-delivery' payment method."
patch -p0 <"${DIR_PATCH}/VSFSUPRU-34.patch"

info "VSFSUPRU-36: Downgrade version for 'vue-carousel'."
patch -p0 <"${DIR_PATCH}/VSFSUPRU-36-1.patch"
patch -p0 <"${DIR_PATCH}/VSFSUPRU-36-2.patch"

info "======================================================================"
info "All patches are applied for 'vue-storefront' app."
info "======================================================================"
