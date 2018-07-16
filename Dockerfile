FROM docker.io/fedora:28
COPY files/ /
RUN \
  dnf install bird hostname procps-ng -y && \
  dnf clean all && \
  rm -rf /var/cache/dnf && \
  chmod 0751 /init/entrypoint.sh
ENTRYPOINT ["/init/entrypoint.sh"]
