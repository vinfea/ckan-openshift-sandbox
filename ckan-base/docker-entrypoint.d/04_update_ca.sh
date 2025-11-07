#!/bin/bash
set -euo pipefail

echo "[INFO] Updating system CA certificates..."

# Ensure the mounted CA directory exists
if [ -d /usr/local/share/ca-certificates ]; then
    echo "[INFO] Found /usr/local/share/ca-certificates. Running update..."
    update-ca-certificates --fresh > /dev/null 2>&1 || {
        echo "[ERROR] Failed to update CA certificates."
        exit 1
    }
    echo "[INFO] CA certificates updated successfully."
else
    echo "[WARN] /usr/local/share/ca-certificates not found — skipping CA update."
fi
