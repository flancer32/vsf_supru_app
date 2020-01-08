#!/usr/bin/env bash
# =========================================================================
#   Deployment configuration template. Copy this file to `cfg.local.sh`
#   and set actual configuration parameters.
# =========================================================================
export DEPLOY_MODE="dev|prod"

export DEBUG_MODE=""       # set "yes" to print commands and their arguments as they are executed
export FAILSAFE_MODE="yes" # set empty to disable fail safe

# VSF frontend
export VSF_FRONT_SERVER_IP="127.0.0.1"
export VSF_FRONT_SERVER_PORT="3100"
export VSF_FRONT_WEB_HOST="front.vsf.test.supru.flancer64.com"
export VSF_FRONT_WEB_PROTOCOL="https"

# VSF API
export VSF_API_SERVER_IP="127.0.0.1"
export VSF_API_SERVER_PORT="3130"
export VSF_API_WEB_HOST="front.vsf.test.supru.flancer64.com"
export VSF_API_WEB_PROTOCOL="https"

# Redis
export REDIS_HOST="127.0.0.1"
export REDIS_PORT="6379"
export REDIS_DB="0"

# Elasticsearch
export ES_HOST="127.0.0.1"
export ES_PORT="9200"
export ES_API_VERSION="7.2"
export ES_URL="http://${ES_HOST}:${ES_PORT}"
export ES_INDEX_NAME="vue_storefront_catalog"

export MAGE_HOST="supplz.ru.local.flancer64.com"
export MAGE_API_CONSUMER_KEY="..."
export MAGE_API_CONSUMER_SECRET="..."
export MAGE_API_ACCESS_TOKEN="..."
export MAGE_API_ACCESS_TOKEN_SECRET="..."
export MAGE_URL_REST="http://${MAGE_HOST}/rest"
export MAGE_URL_IMG="http://${MAGE_HOST}/media/catalog/product"
