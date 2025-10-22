FROM ckan/ckan-base-xloader:1.0.1

USER root

# uwsgi fix
RUN sed -i 's/--uid 92//g' /srv/app/start_ckan.sh && \
    sed -i 's/--gid 92//g' /srv/app/start_ckan.sh

# Ownership and permission changes for Openshift
RUN chgrp -R 0 ${APP_DIR} && \
    chmod -R g=u ${APP_DIR}

# Supervisord

COPY supervisord.conf /etc/supervisord.conf
COPY supervisor.worker.conf /etc/supervisord.d/supervisor.worker.conf

RUN chgrp -R 0 /etc/supervisord.conf && \
    chmod -R g=u /etc/supervisord.conf

RUN chgrp -R 0 /etc/supervisord.d && \
    chmod -R g=u /etc/supervisord.d

USER ckan