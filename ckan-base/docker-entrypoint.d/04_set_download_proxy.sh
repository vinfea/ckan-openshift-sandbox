#!/bin/bash
set -e

CONFIG_FILE="/srv/app/ckan.ini"
KEY="ckan.download_proxy"

echo "[INFO] Starting CKAN config update..."
echo "[INFO] Target file: $CONFIG_FILE"

# Check that the env var is set
if [[ -z "$CKAN_SERVICE_URL" ]]; then
  echo "[ERROR] CKAN_SERVICE_URL is not set. Aborting."
  exit 1
fi

# Check that the file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "[ERROR] Config file not found at $CONFIG_FILE"
  exit 1
fi

# Check if the key already exists
if grep -q "^$KEY" "$CONFIG_FILE"; then
  echo "[INFO] Updating existing $KEY entry..."
  sed -i "s|^$KEY.*|$KEY = ${CKAN_SERVICE_URL}|" "$CONFIG_FILE"
else
  echo "[INFO] Adding new $KEY entry..."
  echo "$KEY = ${CKAN_SERVICE_URL}" >> "$CONFIG_FILE"
fi

echo "[INFO] Update complete. Current setting:"
grep "^$KEY" "$CONFIG_FILE"

echo "[INFO] Done!"
