FROM docker.io/fedora:28
COPY files/ /
RUN \
  dnf update -y && \
  dnf install bird hostname procps-ng iproute -y && \
  dnf clean all && \
  rm -rf /var/cache/dnf && \
  chmod 0751 /init/entrypoint.sh
ENTRYPOINT ["/init/entrypoint.sh"]
