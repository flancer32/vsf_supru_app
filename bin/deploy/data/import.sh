#!/bin/bash
## =========================================================================
#   Import data to Elasticsearch from created dump.
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
DIR_API="${DIR_APPS}/vue-storefront-api"
FILE_DUMP="${DIR_ROOT}/data/dump/supru_vsf_data_test.tar.gz"
IDX_MSK="vsf_msk"

# go to API app root directory
cd "${DIR_API}" || exit 255

info "========================================================================"
info "Import test data into Elasticsearch."
info "========================================================================"

info "Extract test from '${FILE_DUMP}'."
tar -zxf "${FILE_DUMP}" -C "${DIR_API}/var/"

info "Remove current data for '${IDX_MSK}' index from Elasticsearch."
echo node ./scripts/db7.js new -i "${IDX_MSK}"

info "Restore data for '${IDX_MSK}' index in Elasticsearch."
node ./scripts/elastic7.js restore --output-index ${IDX_MSK} --input-file var/${IDX_MSK}.json

info "========================================================================"
info "Test data is imported into Elasticsearch."
info "========================================================================"
