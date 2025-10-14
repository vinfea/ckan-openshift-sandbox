FROM ckan/ckan-base-xloader:1.0.1

USER root

# Ownership and permission changes for Openshift
RUN chgrp -R 0 ${APP_DIR} && \
    chmod -R g=u ${APP_DIR}

USER ckan