#!/bin/bash
## =========================================================================
#   Add own theme to 'vue-storefront'.
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
: "${DEPLOY_MODE:?}"
: "${VSF_FRONT_THEME_CODE:?}"
# local context vars
DIR_APPS="${DIR_ROOT}/apps"
DIR_VSF="${DIR_APPS}/vue-storefront"
DIR_THEME="${DIR_ROOT}/theme"
DIR_ALL="${DIR_THEME}/all"
DIR_CODE="${DIR_THEME}/${VSF_FRONT_THEME_CODE}"
DIR_ALL_FILE="${DIR_ALL}/file"
DIR_ALL_PATCH="${DIR_ALL}/patch"
DIR_CODE_FILE="${DIR_CODE}/file"
DIR_CODE_PATCH="${DIR_CODE}/patch"
DIR_TARGET="${DIR_VSF}/src/themes/default"

# TODO: remove it
DIR_THEME_TARGET="${DIR_VSF}/src/themes/supplz"

info "======================================================================"
info "Deploy own theme to 'vue-storefront' (code '${VSF_FRONT_THEME_CODE}')."
info "======================================================================"

info "======================================================================"
info "Copy own files into 'default' theme."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255
rsync -a "${DIR_ALL_FILE}/" "${DIR_TARGET}/"
rsync -a "${DIR_CODE_FILE}/" "${DIR_TARGET}/"

info "======================================================================"
info "Apply common patches for 'default' theme."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255

patch -p0 <"${DIR_ALL_PATCH}/components/core/blocks/Form/BaseInputNumber.patch"
patch -p0 <"${DIR_ALL_PATCH}/components/core/blocks/Microcart/Product.patch"
patch -p0 <"${DIR_ALL_PATCH}/components/core/ProductAttribute.patch"
patch -p0 <"${DIR_ALL_PATCH}/components/core/ProductQuantity.patch"
patch -p0 <"${DIR_ALL_PATCH}/pages/Category.patch"
patch -p0 <"${DIR_ALL_PATCH}/pages/Compare.patch"
patch -p0 <"${DIR_ALL_PATCH}/pages/Product.patch"

info "======================================================================"
info "Apply '${VSF_FRONT_THEME_CODE}' specific patches for 'default' theme."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255

#info "VSFSUPRU-27: Fix attribute query for Elasticsearch >6.0."
#patch -p0 <"${DIR_CODE_PATCH}/VSFSUPRU-27.patch"

info "======================================================================"
info "Own theme to 'vue-storefront' is deployed."
info "======================================================================"
