#!/usr/bin/env bash
# =========================================================================
#   Deployment configuration template. Copy this file to `cfg.local.sh`
#   and set actual configuration parameters.
# =========================================================================
export DEPLOY_MODE="dev|prod"

export DEBUG_MODE=""       # set "yes" to print commands and their arguments as they are executed
export FAILSAFE_MODE="yes" # set empty to disable fail safe

export VSF_HOST="127.0.0.1"
export VSF_PORT="3030"

export VSF_API_HOST="127.0.0.1"
export VSF_API_PORT="8080"

export REDIS_HOST="127.0.0.1"
export REDIS_PORT="6379"
export REDIS_DB="0"

export ES_HOST="127.0.0.1"
export ES_PORT="9200"
export ES_URL="http://${ES_HOST}:${ES_PORT}"
export ES_INDEX_NAME="vue_storefront_catalog"

export MAGE_HOST="biobox.local.flancer64.com"
export MAGE_API_CONSUMER_KEY="soxqc5hzir8lwcd713e2m9c8vzo7zole"
export MAGE_API_CONSUMER_SECRET="9ggeetmo99w6bv55s6vmt1jx8ogiwemq"
export MAGE_API_ACCESS_TOKEN="hpzzmo9mrvmvhhjjw2d568noi08nneoh"
export MAGE_API_ACCESS_TOKEN_SECRET="dpie6tdvb30gw53y3uzyevn012on9n5u"
export MAGE_URL_REST="http://${MAGE_HOST}/rest"
export MAGE_URL_IMG="http://${MAGE_HOST}/media/catalog/product"
