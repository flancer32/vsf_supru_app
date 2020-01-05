#!/usr/bin/env/bash
## =========================================================================
#   Deploy 'vue-storefront-api' application for the project.
## =========================================================================
# shellcheck disable=SC1090 # Can't follow non-constant source.
# root directory (set before or relative to the current shell script)
DIR_ROOT=${DIR_ROOT:=$(cd "$(dirname "$0")/../../" && pwd)}
# load local config and define common functions
. "${DIR_ROOT}/bin/commons.sh"

## =========================================================================
#   Setup & validate working environment
## =========================================================================
# check external vars used in this script (see cfg.[work|live].sh)
: "${DEPLOY_MODE:?}"
: "${DEPLOY_MODE_DEV:?}"
: "${ES_HOST:?}"
: "${ES_PORT:?}"
: "${MAGE_API_ACCESS_TOKEN:?}"
: "${MAGE_API_ACCESS_TOKEN_SECRET:?}"
: "${MAGE_API_CONSUMER_KEY:?}"
: "${MAGE_API_CONSUMER_SECRET:?}"
: "${MAGE_HOST:?}"
: "${MAGE_URL_IMG:?}"
: "${MAGE_URL_REST:?}"
: "${REDIS_HOST:?}"
: "${REDIS_PORT:?}"
: "${VSF_API_HOST:?}"
: "${VSF_API_PORT:?}"
# local context vars
DIR_APPS="${DIR_ROOT}/apps"
DIR_VSF_API="${DIR_APPS}/vue-storefront-api"

# create applications root directory if not exist
test ! -d "${DIR_APPS}" && mkdir -p "${DIR_APPS}"
cd "${DIR_APPS}" || exit 255

info "========================================================================"
info "Clone 'vue-storefront-api' app."
info "========================================================================"
git clone https://github.com/DivanteLtd/vue-storefront.git "${DIR_VSF_API}"
cd "${DIR_VSF_API}" || exit 255

info "========================================================================"
info "Create local config for 'vue-storefront-api' app."
info "========================================================================"
cat <<EOM | tee "${DIR_VSF_API}/config/local.json"
{
  "server": {
    "host": "${VSF_API_HOST}",
    "port": ${VSF_API_PORT}
  },
  "elasticsearch": {
    "host": "${ES_HOST}",
    "port": ${ES_PORT},
    "apiVersion": "7.1"
  },
  "redis": {
    "host": "${REDIS_HOST}",
    "port": ${REDIS_PORT}
  },
  "magento2": {
    "imgUrl": "${MAGE_URL_IMG}",
    "api": {
      "url": "${MAGE_URL_REST}",
      "consumerKey": "${MAGE_API_CONSUMER_KEY}",
      "consumerSecret": "${MAGE_API_CONSUMER_SECRET}",
      "accessToken": "${MAGE_API_ACCESS_TOKEN}",
      "accessTokenSecret": "${MAGE_API_ACCESS_TOKEN_SECRET}"
    }
  },
  "imageable": {
    "whitelist": {
      "allowedHosts": [
        "${MAGE_HOST}"
      ]
    }
  }
}
EOM

info "========================================================================"
info "Build 'vue-storefront-api' app in '${DEPLOY_MODE}' mode."
info "========================================================================"
# build app according to the deployment mode (default: production)
if test "${DEPLOY_MODE}" != "${DEPLOY_MODE_DEV}"; then
  git checkout "v1.11.0"
  yarn install
#  yarn build
else
  info "deploy in dev mode"
fi

info "========================================================================"
info "'vue-storefront-api' app is deployed in '${DEPLOY_MODE}' mode."
info "========================================================================"
