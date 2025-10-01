3 files:
- prerun.py.override
- start_ckan.sh.override
- start_ckan_development.sh.override

These setup files (minus the .override) are in the ckan-base image (which we build on top of in our Dockerfile).

Files in this folder should be used to override default setup behaviour (I think).

This folder is not referenced in the given Dockerfile but of course can be.