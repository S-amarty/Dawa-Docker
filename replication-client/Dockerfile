FROM node:12-bullseye-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      postgresql-client \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g @dawadk/replication-client@1.3.19

RUN useradd --system dawa-replicator

WORKDIR /app

RUN mkdir config
COPY config/* config/
RUN chown -R dawa-replicator /app/config && chmod -R 700 /app/config

COPY wrapper.sh .
RUN chown dawa-replicator wrapper.sh && chmod 700 wrapper.sh

USER dawa-replicator

ENTRYPOINT ["bash", "./wrapper.sh"]
