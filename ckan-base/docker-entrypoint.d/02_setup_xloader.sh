#!/bin/bash

echo "************************SETUP XLOADER FILE************************"
echo "CKAN_INI = $CKAN_INI"
echo "CKAN__PLUGINS = $CKAN__PLUGINS"
echo "CKAN__XLOADER__API_TOKEN = ${CKAN__XLOADER__API_TOKEN:-<not set>}"
echo "---------------------------------------------------------------"

if [[ $CKAN__PLUGINS == *"xloader"* ]]; then
   # Datapusher settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKAN__XLOADER__API_TOKEN" ] ; then
      echo "No API token provided; generating a new one..."
      echo "Set up ckanext.xloader.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckanext.xloader.api_token=$(ckan -c $CKAN_INI user token add ckan_admin xloader | tail -n 1 | tr -d '\t')"
   else
      echo "API token already provided: ${CKAN__XLOADER__API_TOKEN:0:6}******"
   fi
else
   echo "Not configuring xloader"
fi