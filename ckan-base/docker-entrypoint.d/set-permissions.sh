#!/bin/bash
set -e

# This script runs after prerun.py, before CKAN starts
echo "Fixing permissions for OpenShift random UID..."

# Directories to fix
DIRS="/srv/app /var/lib/ckan"

for d in $DIRS; do
    if [ -d "$d" ]; then
        echo "Processing $d"
        # Set group to 0 (root group) and give group the same permissions as owner
        chgrp -R 0 "$d"
        chmod -R g=u "$d"
    else
        echo "Directory $d does not exist, skipping"
    fi
done

echo "Permissions fixed!"
