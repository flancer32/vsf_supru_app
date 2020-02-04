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
# local context vars
DIR_APPS="${DIR_ROOT}/apps"
DIR_VSF="${DIR_APPS}/vue-storefront"
DIR_THEME="${DIR_VSF}/src/themes/supplz"

info "======================================================================"
info "Add own theme to 'vue-storefront' (branch '${VSF_FRONT_THEME_BRANCH}')."
info "======================================================================"

git clone git@github.com:flancer32/vsf_supru_theme.git "${DIR_THEME}"
cd "${DIR_THEME}" || exit 255
git checkout "${VSF_FRONT_THEME_BRANCH}"

info "======================================================================"
info "Own theme to 'vue-storefront' is aded."
info "======================================================================"
