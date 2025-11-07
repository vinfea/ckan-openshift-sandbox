#!/bin/bash
set -euo pipefail

# Directory where your CA certs are mounted (Secret)
CA_MOUNT_DIR="/srv/app"

# Directory where your container user can write the trust bundle
LOCAL_CA_DIR="/srv/app/ca-certs"
LOCAL_CA_BUNDLE="${LOCAL_CA_DIR}/ca-bundle.crt"

echo "[INFO] Creating local CA trust store..."

# Make sure the local CA directory exists
mkdir -p "${LOCAL_CA_DIR}"

# Copy all mounted CA certs into the local CA directory
if [ -d "${CA_MOUNT_DIR}" ]; then
    cp "${CA_MOUNT_DIR}"/*.pem "${LOCAL_CA_DIR}/"
else
    echo "[WARN] Mounted CA directory ${CA_MOUNT_DIR} not found. Skipping."
fi

# Build a single CA bundle for Python / requests / curl
cat "${LOCAL_CA_DIR}"/*.pem > "${LOCAL_CA_BUNDLE}"

echo "[INFO] Local CA bundle created at ${LOCAL_CA_BUNDLE}"
