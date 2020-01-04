#!/usr/bin/env/bash
## =========================================================================
#   Deploy 'vue-storefront' application for the project.
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
: "${ES_INDEX_NAME=:?}"
: "${REDIS_DB:?}"
: "${REDIS_HOST:?}"
: "${REDIS_PORT:?}"
: "${VSF_API_HOST:?}"
: "${VSF_API_PORT:?}"
: "${VSF_HOST:?}"
: "${VSF_PORT:?}"
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

info "========================================================================"
info "Create local config for 'vue-storefront' app."
info "========================================================================"
cat <<EOM | tee "${DIR_VSF}/config/local.json"
{
  "server": {
    "host": "${VSF_HOST}",
    "port": ${VSF_PORT}
  },
  "redis": {
    "host": "${REDIS_HOST}",
    "port": ${REDIS_PORT},
    "db": ${REDIS_DB}
  },
  "api": {
    "url": "http://${VSF_API_HOST}:${VSF_API_PORT}"
  },
  "elasticsearch": {
    "indices": [
      "${ES_INDEX_NAME}"
    ]
  },
  "images": {
    "useExactUrlsNoProxy": false,
    "baseUrl": "http://${VSF_API_HOST}:${VSF_API_PORT}/img/",
    "productPlaceholder": "/assets/placeholder.jpg"
  },
  "i18n": {
    "defaultCountry": "RU",
    "defaultLanguage": "RU",
    "availableLocale": ["ru-RU"],
    "defaultLocale": "ru-RU",
    "currencyCode": "RUB",
    "currencySign": "₽",
    "currencySignPlacement": "preppend",
    "dateFormat": "l LT",
    "fullCountryName": "Russian Federation",
    "fullLanguageName": "Russian",
    "bundleAllStoreviewLanguages": true
  }
}
EOM

info "========================================================================"
info "Build 'vue-storefront' app according to '${DEPLOY_MODE}' mode."
info "========================================================================"
# build app according to the deployment mode (default: production)
if test "${DEPLOY_MODE}" != "${DEPLOY_MODE_DEV}"; then
  git checkout -b "v1.11.0"
  yarn install
  yarn build
else
  info "deploy in dev mode"
fi

info "========================================================================"
info "'vue-storefront' app is deployed in '${DEPLOY_MODE}' mode."
info "========================================================================"
