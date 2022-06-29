#!/bin/bash
set -exo pipefail

if [[ -z "${CUSTOM_PORT}" ]]; then
    echo "Environment variable: CUSTOM_PORT is not set. Exiting."
    exit 1
fi

if [[ -z "${CONFIG_JSON_REWRITE_DIR}" ]]; then
    echo "Environment variable: CONFIG_JSON_REWRITE_DIR is not set. Exiting."
    exit 1
fi

cat /etc/nginx/conf.d/default.conf | sed "s|__CUSTOM_PORT__|${CUSTOM_PORT}|" | tee /etc/nginx/conf.d/default.conf > /dev/null
cat /etc/nginx/conf.d/default.conf | sed "s|__CONFIG_JSON_REWRITE_DIR__|${CONFIG_JSON_REWRITE_DIR}|" | tee /etc/nginx/conf.d/default.conf > /dev/null

cat /etc/nginx/conf.d/default.conf



nginx -g 'daemon off;'