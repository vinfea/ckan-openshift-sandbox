FROM ckan/ckan-base-xloader:1.0.1

USER root

# uwsgi fix
RUN sed -i 's/--uid 92//g' /srv/app/start_ckan.sh && \
    sed -i 's/--gid 92//g' /srv/app/start_ckan.sh

# Testing
RUN mkdir -p /stupid/test/incineroar && \
    chgrp -R 0 /stupid/test/incineroar && \
    chmod -R g=u /stupid/test/incineroar

# Ownership and permission changes for Openshift
RUN chgrp -R 0 ${APP_DIR} && \
    chmod -R g=u ${APP_DIR}

USER ckan