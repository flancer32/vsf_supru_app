#!/usr/bin/env bash
# =========================================================================
#   Deployment configuration template. Copy this file to `cfg.local.sh`
#   and set actual configuration parameters.
# =========================================================================
export DEPLOY_MODE="dev|prod"

export DEBUG_MODE=""          # set "yes" to print commands and their arguments as they are executed
export FAILSAFE_MODE="yes"    # set empty to disable fail safe


export VSF_HOST="127.0.0.1"
export VSF_PORT="3030"

export VSF_API_HOST="127.0.0.1"
export VSF_API_PORT="8080"

export REDIS_HOST="127.0.0.1"
export REDIS_PORT="6379"
export REDIS_DB="0"

export ES_INDEX_NAME="vue_storefront_catalog"

