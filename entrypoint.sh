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

cat /etc/nginx/nginx.conf | sed "s|__CUSTOM_PORT__|${CUSTOM_PORT}|" | tee /etc/nginx/nginx.conf > /dev/null
cat /etc/nginx/nginx.conf | sed "s|__CONFIG_JSON_REWRITE_DIR__|${CONFIG_JSON_REWRITE_DIR}|" | tee /etc/nginx/nginx.conf > /dev/null

cat /etc/nginx/nginx.conf


cat > /usr/share/nginx/html/custom.css <<EON
#root {
  background: url(__BACKGROUND_IMAGE_URL__) no-repeat #111 !important;
  background-position: __BACKGROUND_POSITION__!important;
}
EON

cat /usr/share/nginx/html/custom.css | sed "s|__BACKGROUND_POSITION__|${BACKGROUND_POSITION}|" | tee /usr/share/nginx/html/custom.css > /dev/null
cat /usr/share/nginx/html/custom.css | sed "s|__BACKGROUND_IMAGE_URL__|${BACKGROUND_IMAGE_URL}|" | tee /usr/share/nginx/html/custom.css > /dev/null

ls -la /usr/share/nginx/html


nginx -g 'daemon off;'