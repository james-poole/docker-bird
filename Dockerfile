FROM docker.io/fedora:28
COPY files/ /
RUN \
  dnf install bird iproute initscripts -y && \
  chmod 0700 /init/entrypoint.sh
ENTRYPOINT ["/init/entrypoint.sh"]
