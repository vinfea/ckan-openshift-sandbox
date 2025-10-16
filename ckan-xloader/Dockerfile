FROM ckan/ckan-base-xloader:1.0.1

USER root

# uwsgi fix
RUN sed -i '/^uid =/d' /etc/uwsgi/uwsgi.ini && \
    sed -i '/^gid =/d' /etc/uwsgi/uwsgi.ini && \
    sed -i '/^cap =/d' /etc/uwsgi/uwsgi.ini && \
    sed -i '/^emperor/d' /etc/uwsgi/uwsgi.ini && \
    echo -e "[uwsgi]\nmaster = true\nprocesses = 2\nhttp-socket = :8080\nchdir = /srv/app\nwsgi-file = wsgi.py\ncallable = application" > /etc/uwsgi/uwsgi.ini

# Testing
RUN mkdir -p /stupid/test/incineroar && \
    chgrp -R 0 /stupid/test/incineroar && \
    chmod -R g=u /stupid/test/incineroar

# Ownership and permission changes for Openshift
RUN chgrp -R 0 ${APP_DIR} && \
    chmod -R g=u ${APP_DIR}

USER ckan

# Override entrypoint to avoid setuid/setgid
ENTRYPOINT ["uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]