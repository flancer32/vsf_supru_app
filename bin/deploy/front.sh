#!/bin/bash
## =========================================================================
#   Deploy 'vue-storefront' application for the project.
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../" && pwd)}
DIR_CUR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# load local config and define common functions
. "${DIR_ROOT}/bin/lib/commons.sh"

## =========================================================================
#   Setup & validate working environment
## =========================================================================
# check external vars used in this script (see cfg.[work|live].sh)
: "${DEPLOY_MODE:?}"
: "${DEPLOY_MODE_DEV:?}"
: "${ES_INDEX_NAME=:?}"
: "${REDIS_DB:?}"
: "${REDIS_HOST:?}"
: "${REDIS_PORT:?}"
: "${VSF_API_SERVER_IP:?}"
: "${VSF_API_SERVER_PORT:?}"
: "${VSF_API_WEB_HOST:?}"
: "${VSF_API_WEB_PROTOCOL:?}"
: "${VSF_FRONT_SERVER_IP:?}"
: "${VSF_FRONT_SERVER_PORT:?}"
: "${VSF_FRONT_WEB_HOST:?}"
: "${VSF_FRONT_WEB_PROTOCOL:?}"
# local context vars
DIR_APPS="${DIR_ROOT}/apps"
DIR_VSF="${DIR_APPS}/vue-storefront"

# create applications root directory if not exist
test ! -d "${DIR_APPS}" && mkdir -p "${DIR_APPS}"
cd "${DIR_APPS}" || exit 255

info "========================================================================"
info "Clone 'vue-storefront' app."
info "========================================================================"
git clone https://github.com/DivanteLtd/vue-storefront.git "${DIR_VSF}"
cd "${DIR_VSF}" || exit 255
# checkout exact version of app below (dependend on deploy mode)

info "========================================================================"
info "Create local config for 'vue-storefront' app."
info "========================================================================"
envsubst <"${DIR_CUR}/front/local.json" >"${DIR_VSF}/config/local.json"

info "========================================================================"
info "Build 'vue-storefront' app in '${DEPLOY_MODE}' mode."
info "========================================================================"
# build app according to the deployment mode (default: production)
if test "${DEPLOY_MODE}" != "${DEPLOY_MODE_DEV}"; then
  git checkout "v1.11.2"

  cd "${DIR_ROOT}" || exit 255
  . "${DIR_CUR}/front/theme.sh"
  . "${DIR_CUR}/front/patch.sh"

  cd "${DIR_VSF}" || exit 255
  yarn install
  yarn build

else
  info "deploy manually in dev mode"
fi

info "========================================================================"
info "'vue-storefront' app is deployed in '${DEPLOY_MODE}' mode."
info "========================================================================"
