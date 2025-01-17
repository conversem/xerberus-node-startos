FROM ghcr.io/xerberusteam/xerberus-node:full-node-latest
USER root

# Install tini
RUN apt-get update && apt-get install -y tini
RUN chmod +x /usr/bin/xerberus-net
# Add and make entrypoint executable
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

# Create data directory with proper permissions
RUN mkdir -p /root/data && chown -R root:root /root/data

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]

