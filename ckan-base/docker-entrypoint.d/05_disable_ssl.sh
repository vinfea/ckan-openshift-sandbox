#!/bin/bash
set -e

CONFIG_FILE="/srv/app/ckan.ini"
KEY="ckanext.xloader.ssl_verify"
VALUE="False"

echo "[INFO] Starting CKAN config update..."
echo "[INFO] Target file: $CONFIG_FILE"

# Check that the file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "[ERROR] Config file not found at $CONFIG_FILE"
  exit 1
fi

# Check if the key already exists
if grep -q "^$KEY" "$CONFIG_FILE"; then
  echo "[INFO] Updating existing $KEY entry..."
  sed -i "s|^$KEY.*|$KEY = $VALUE|" "$CONFIG_FILE"
else
  echo "[INFO] Adding new $KEY entry..."
  echo "$KEY = $VALUE" >> "$CONFIG_FILE"
fi

echo "[INFO] Update complete. Current setting:"
grep "^$KEY" "$CONFIG_FILE"

echo "[INFO] Done!"
