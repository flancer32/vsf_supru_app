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
DIR_CODE="${DIR_THEME}/${DIR_THEME_TARGET}"
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
#echo "TEMPORARY CODE TO GET INITITAL THEME:"
#git clone git@github.com:flancer32/vsf_supru_theme.git "${DIR_THEME_TARGET}"
#cd "${DIR_THEME_TARGET}" || exit 255
#git checkout "${VSF_FRONT_THEME_CODE}"
#echo "END OF TEMPORARY CODE TO GET INITITAL THEME"

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

##
# Don't change patches order!!!
##

info "VSFSUPRU-14: Add separator to product attributes list."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-14.patch"

info "VSFSUPRU-16: Missed attributes names in Products comparison."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-16.patch"

info "VSFSUPRU-27: Add inc/dec buttons to product details."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-27-1.patch"
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-27-2.patch"
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-27-3.patch"

info "VSFSUPRU-22: Group prices for customers."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-22-1.patch"
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-22-2.patch"

info "VSFSUPRU-29: Add inc/dec buttons to mini-cart."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-29.patch"

info "VSFSUPRU-30: Direct URL for categories."
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-30-1.patch"
patch -p0 <"${DIR_ALL_PATCH}/VSFSUPRU-30-2.patch"

info "======================================================================"
info "Apply '${VSF_FRONT_THEME_CODE}' specific patches for 'default' theme."
info "======================================================================"
cd "${DIR_ROOT}" || exit 255

#info "VSFSUPRU-27: Fix attribute query for Elasticsearch >6.0."
#patch -p0 <"${DIR_CODE_PATCH}/VSFSUPRU-27.patch"

info "======================================================================"
info "Own theme to 'vue-storefront' is deployed."
info "======================================================================"
