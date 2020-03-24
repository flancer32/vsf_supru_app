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
cat <<EOM | tee "${DIR_VSF}/config/local.json"
{
  "server": {
    "host": "${VSF_FRONT_SERVER_IP}",
    "port": ${VSF_FRONT_SERVER_PORT},
    "protocol": "http"
  },
  "redis": {
    "host": "${REDIS_HOST}",
    "port": ${REDIS_PORT},
    "db": ${REDIS_DB}
  },
  "api": {
    "url": "${VSF_API_WEB_PROTOCOL}://${VSF_API_WEB_HOST}"
  },
  "elasticsearch": {
    "index": "${ES_INDEX_NAME}"
  },
  "storeViews": {
    "mapStoreUrlsFor": []
  },
  "entities": {
    "productList": {
      "includeFields": [
        "*image",
        "*sku",
        "*small_image",
        "activity",
        "aktivnost",
        "anatomichnost",
        "aromat",
        "artikul_postavschika",
        "artikul_proizvoditelja",
        "brend",
        "configurable_children.color",
        "configurable_children.final_price",
        "configurable_children.original_price",
        "configurable_children.original_price_incl_tax",
        "configurable_children.price",
        "configurable_children.price_incl_tax",
        "configurable_children.size",
        "configurable_children.sku",
        "configurable_children.special_price",
        "configurable_children.special_price_incl_tax",
        "configurable_children.tier_prices",
        "custom_label",
        "cvet",
        "diametr",
        "diametr_dna",
        "diametr_gorla",
        "dizajn",
        "dlina",
        "final_price",
        "group_prices",
        "id",
        "image",
        "kol_vo_listov",
        "kol_vo_sloev",
        "kolichestvo_v_korobe",
        "material",
        "name",
        "naznachenie",
        "new",
        "ob_em_komfortnyj",
        "ob_em_l",
        "ob_em_ml",
        "opudrennost",
        "original_price",
        "original_price_incl_tax",
        "osobennosti",
        "plotnost",
        "postavschik",
        "price",
        "price_incl_tax",
        "product_links",
        "proizvoditel",
        "razmer",
        "sale",
        "shirina",
        "sistema_dispenserov",
        "sku_id",
        "sobstvennaja_zakupka",
        "special_from_date",
        "special_price",
        "special_price_incl_tax",
        "special_to_date",
        "status",
        "stepen_obzharki",
        "stock",
        "strana_proizvodstva",
        "tax_class_id",
        "teksturirovannost",
        "tier_prices",
        "tip_slozhenija",
        "tolschina",
        "tolschina_stali_mm",
        "type_id",
        "url_key",
        "url_path",
        "ves",
        "vid_bumagi",
        "vid_tovara",
        "vkus",
        "vygruzhat_na_sajt",
        "vysota"
      ]
    },
    "productListWithChildren": {
      "includeFields": [
        "activity",
        "aktivnost",
        "anatomichnost",
        "aromat",
        "artikul_postavschika",
        "artikul_proizvoditelja",
        "brend",
        "configurable_children.color",
        "configurable_children.final_price",
        "configurable_children.id",
        "configurable_children.image",
        "configurable_children.original_price",
        "configurable_children.original_price_incl_tax",
        "configurable_children.price",
        "configurable_children.price_incl_tax",
        "configurable_children.regular_price",
        "configurable_children.size",
        "configurable_children.sku",
        "configurable_children.special_from_date",
        "configurable_children.special_price",
        "configurable_children.special_price_incl_tax",
        "configurable_children.special_to_date",
        "configurable_children.tier_prices",
        "custom_label",
        "cvet",
        "diametr",
        "diametr_dna",
        "diametr_gorla",
        "dizajn",
        "dlina",
        "final_price",
        "group_prices",
        "id",
        "image",
        "kol_vo_listov",
        "kol_vo_sloev",
        "kolichestvo_v_korobe",
        "material",
        "name",
        "naznachenie",
        "new",
        "ob_em_komfortnyj",
        "ob_em_l",
        "ob_em_ml",
        "opudrennost",
        "original_price",
        "original_price_incl_tax",
        "osobennosti",
        "plotnost",
        "postavschik",
        "price",
        "price_incl_tax",
        "product_links",
        "proizvoditel",
        "razmer",
        "sale",
        "shirina",
        "sistema_dispenserov",
        "sku",
        "sku_id",
        "sobstvennaja_zakupka",
        "special_from_date",
        "special_price",
        "special_price_incl_tax",
        "special_to_date",
        "status",
        "stepen_obzharki",
        "stock",
        "strana_proizvodstva",
        "tax_class_id",
        "teksturirovannost",
        "tier_prices",
        "tip_slozhenija",
        "tolschina",
        "tolschina_stali_mm",
        "type_id",
        "url_key",
        "url_path",
        "ves",
        "vid_bumagi",
        "vid_tovara",
        "vkus",
        "vygruzhat_na_sajt",
        "vysota"
      ]
    },
    "category": {
      "excludeFields": null
    },
    "product": {
      "excludeFields": null,
      "standardSystemFields": [
        "bundle_options",
        "category_ids",
        "configurable_options",
        "custom_options",
        "description",
        "group_prices",
        "id",
        "image",
        "meta_description",
        "meta_title",
        "name",
        "original_price_incl_tax",
        "parentSku",
        "price_incl_tax",
        "product_links",
        "qty",
        "sku",
        "slug",
        "special_price",
        "status",
        "stock",
        "type_id",
        "updated_at",
        "url_path",
        "visibility"
      ]
    }
  },
  "products": {
    "defaultFilters": []
  },
  "images": {
    "useExactUrlsNoProxy": false,
    "baseUrl": "${VSF_API_WEB_PROTOCOL}://${VSF_API_WEB_HOST}/img/",
    "productPlaceholder": "/assets/placeholder.jpg"
  },
  "install": {
    "is_local_backend": true
  },
  "tax": {
    "defaultCountry": "RU"
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
  },
  "theme": "@supplz/vsf-theme-ru"
}
EOM

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
