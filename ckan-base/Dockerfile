FROM ckan/ckan-base:2.11.3

ARG XLOADER_VERSION=${XLOADER_VERSION}

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

USER root

# Install the XLoader extension
RUN pip3 install -U pip && \ 
    cd ${SRC_DIR} && \
    pip3 install -e git+https://github.com/ckan/ckanext-xloader.git@${XLOADER_VERSION}#egg=ckanext-xloader && \
    pip3 install -r ckanext-xloader/requirements.txt && \
    pip3 install -U requests[security]

# Install Gov Canada Theme extensions

# 1) Clone git repos
RUN cd ${SRC_DIR} && \
    git clone https://github.com/asc-csa/ckanext-asc-csa-scheming && \
    git clone https://github.com/ckan/ckanext-fluent.git && \
    git clone https://github.com/asc-csa/ckanext-asc-csa

# 2) Install extensions
RUN cd ${SRC_DIR}/ckanext-asc-csa-scheming && \
    pip install -r requirements.txt && \
    python setup.py develop 

RUN cd ${SRC_DIR}/ckanext-fluent && \
    python setup.py develop

RUN cd ${SRC_DIR}/ckanext-asc-csa && \
    python setup.py develop

# 3) Apply custom Solr schema
RUN cp ${SRC_DIR}/ckanext-asc-csa/ckanext/csa/conf/solr/schema.xml ${SRC_DIR}/ckan/ckan/config/solr/schema.xml

# Install nano text editor
RUN apt-get update && \
    apt-get install -y nano && \
    rm -rf /var/lib/apt/lists/*

# Copy custom initialization scripts
COPY --chown=ckan-sys:ckan-sys docker-entrypoint.d/* /docker-entrypoint.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY --chown=ckan-sys:ckan-sys patches ${APP_DIR}/patches

# Copy override files in setup/
COPY setup/prerun.py.override ${APP_DIR}/prerun.py
COPY setup/start_ckan.sh.override ${APP_DIR}/start_ckan.sh

# Ownership and permission changes for Openshift
RUN mkdir -p ${APP_DIR} /etc/ckan /var/lib/ckan \
    && chgrp -R 0 ${APP_DIR} /etc/ckan /var/lib/ckan \
    && chmod -R g+rwX ${APP_DIR} /etc/ckan /var/lib/ckan \
    && chmod g+s ${APP_DIR} /etc/ckan /var/lib/ckan

RUN chmod g+rx ${APP_DIR}/start_ckan.sh

# CSA extension permission changes
RUN chgrp -R 0 /usr/local/lib/python3.10/site-packages/geojson \
    && chmod -R g+rwX /usr/local/lib/python3.10/site-packages/geojson

# Overwrite CSA files
COPY gov-extension/helpers.py /srv/app/src/ckanext-asc-csa/ckanext/csa/helpers.py
COPY gov-extension/plugin.py /srv/app/src/ckanext-asc-csa/ckanext/csa/plugin.py
COPY gov-extension/mapping.py /usr/local/lib/python3.10/site-packages/geojson/mapping.py

USER ckan

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done