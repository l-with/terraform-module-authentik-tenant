#!/bin/sh

if [ x"${AUTHENTIK_URL}" == "x" ]; then
  echo "AUTHENTIK_URL is not set"
  exit 1
fi

if [ x"${AUTHENTIK_TOKEN}" == "x" ]; then
  echo "AUTHENTIK_TOKEN is not set"
  exit 2
fi

if [ x"${AUTHENTIK_DEFAULT_TENANT_DOMAIN}" == "x" ]; then
  echo "AUTHENTIK_DEFAULT_TENANT_DOMAIN is not set"
  exit 3
fi

if [ x"${AUTHENTIK_DEFAULT_TENANT_DEFAULT}" == "x" ]; then
  echo "AUTHENTIK_DEFAULT_TENANT_DEFAULT is not set"
  exit 4
fi

_JSON_RESPONSE=$(curl -X GET "${AUTHENTIK_URL}/api/v3/core/tenants/?domain=${AUTHENTIK_DEFAULT_TENANT_DOMAIN}" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${AUTHENTIK_TOKEN}")

_TENANT_UUID=$(echo $_JSON_RESPONSE | grep -o '"tenant_uuid":"[^"]*' | grep -o '[^"]*$')

_PAYLOAD="{\"default\":${AUTHENTIK_DEFAULT_TENANT_DEFAULT},\"domain\":\"${AUTHENTIK_DEFAULT_TENANT_DOMAIN}\"}"

curl -X PUT "${AUTHENTIK_URL}/api/v3/core/tenants/${_TENANT_UUID}/" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${AUTHENTIK_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "${_PAYLOAD}"

