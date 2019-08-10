FROM alpine:3.10

# Install runtime dependencies. The versions are pinned for reproducible,
# deterministic, pure builds.
RUN apk --update add \
  wget \
  curl \
  openvpn

# Log the public ip address of the container in every minute.
HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
  CMD curl 'https://api.ipify.org'

# This is where the configuration files will go.
VOLUME [ "/vpn/config" ]

CMD [ "openvpn", "--config", "/vpn/config/config.ovpn" ]
