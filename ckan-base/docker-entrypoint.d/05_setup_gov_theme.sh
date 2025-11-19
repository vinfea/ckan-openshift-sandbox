#!/bin/bash

CKAN_INI="${CKAN_INI:-/srv/app/ckan.ini}"

echo "******************** CONFIGURING GOV THEME ********************"
echo "CKAN_INI = $CKAN_INI"
echo "-----------------------------------------------------------------------------"

# Run config-tool updates
ckan config-tool "$CKAN_INI" \
    "scheming.dataset_schemas=ckanext.scheming:ckan_dataset.json ckanext.csa:info.json ckanext.csa:doc.json" \
    "scheming.presets=ckanext.scheming:presets.json ckanext.fluent:presets.json" \
    "licenses_group_url=file:///usr/lib/ckan/default/src/ckanext-asc-csa/ckanext/csa/public/licenses.json" \
    "ckan.locale_default=en" \
    "ckan.locale_order=en fr" \
    "ckan.locales_offered=en fr"

echo "-----------------------------------------------------------------------------"
echo "Scheming configuration successfully applied to $CKAN_INI"
echo "*****************************************************************************"
