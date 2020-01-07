#!/usr/bin/env/bash
## =========================================================================
#   Deploy 'mage2vuestorefront' application for the project.
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
: "${ES_INDEX_NAME:?}"
: "${ES_URL:?}"
: "${MAGE_API_ACCESS_TOKEN:?}"
: "${MAGE_API_ACCESS_TOKEN_SECRET:?}"
: "${MAGE_API_CONSUMER_KEY:?}"
: "${MAGE_API_CONSUMER_SECRET:?}"
: "${MAGE_URL_REST:?}"
# local context vars
DIR_APPS="${DIR_ROOT}/apps"
DIR_M2V="${DIR_APPS}/mage2vuestorefront"

# create applications root directory if not exist
test ! -d "${DIR_APPS}" && mkdir -p "${DIR_APPS}"
cd "${DIR_APPS}" || exit 255

info "========================================================================"
info "Clone 'mage2vuestorefront' app."
info "========================================================================"
git clone https://github.com/DivanteLtd/mage2vuestorefront.git "${DIR_M2V}"
cd "${DIR_M2V}" || exit 255
git checkout "feature/es7"

info "========================================================================"
info "Create local config for 'mage2vuestorefront' app."
info "========================================================================"
# see "apps/mage2vuestorefront/src/config.js" for available env. params
cat <<EOM | tee "${DIR_M2V}/replicate_msk.sh"
#!/usr/bin/env/bash
#  Exit immediately if a command exits with a non-zero status.
set -e
ROOT=\$(cd "\$(dirname "\$0")/" && pwd)
M2V_CLI="\${ROOT}/src/cli.js"

export TIME_TO_EXIT="2000"

# Setup connection to Magento
export ELASTICSEARCH_API_VERSION="7.1"
export DATABASE_URL="${ES_URL}"

# Setup connection to Magento
export MAGENTO_CONSUMER_KEY="${MAGE_API_CONSUMER_KEY}"
export MAGENTO_CONSUMER_SECRET="${MAGE_API_CONSUMER_SECRET}"
export MAGENTO_ACCESS_TOKEN="${MAGE_API_ACCESS_TOKEN}"
export MAGENTO_ACCESS_TOKEN_SECRET="${MAGE_API_ACCESS_TOKEN_SECRET}"
export MAGENTO_URL="${MAGE_URL_REST}"

# Setup default store
export INDEX_NAME="${ES_INDEX_NAME}"

# Perform data replications
node --harmony "\${M2V_CLI}" taxrule --removeNonExistent=true
node --harmony "\${M2V_CLI}" attributes --removeNonExistent=true
node --harmony "\${M2V_CLI}" categories --removeNonExistent=true
node --harmony "\${M2V_CLI}" productcategories
node --harmony "\${M2V_CLI}" products --removeNonExistent=true
EOM

info "========================================================================"
info "Build 'mage2vuestorefront' app in '${DEPLOY_MODE}' mode."
info "========================================================================"
# build app according to the deployment mode (default: production)
if test "${DEPLOY_MODE}" != "${DEPLOY_MODE_DEV}"; then
  yarn install
else
  info "deploy in dev mode"
fi

info "========================================================================"
info "'mage2vuestorefront' app is deployed in '${DEPLOY_MODE}' mode."
info "========================================================================"
