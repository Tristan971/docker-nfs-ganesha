FROM fedora:32

# Install dependencies
RUN dnf install -y \
  nfs-ganesha \
  nfs-ganesha-vfs \
  nfs-utils \
  rpcbind \
  dbus \
  dbus-daemon \
  dbus-tools \
  && dnf clean all

ADD start_nfs.sh /bin/start_nfs.sh

# Add tini and set it as entrypoint
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-amd64 /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Invoke NFS-Ganesha startup, via tini
CMD ["/bin/start_nfs.sh"]
