#!/bin/bash
set -e

DEFAULT_SYNC_PERIOD=${REPLICATOR_SYNC_PERIOD:-3600}

wait_for_db() {
  until psql "${DATABASE_URL}" -c '\q' > /dev/null 2>&1; do
    >&2 echo "INFO: Waiting for PostgreSQL at $DATABASE_URL..."
    sleep 5
  done
}

execute_replication() {
  echo "INFO: Starting replication at $(date)"
  for cfg in config/config_*.json; do
    dawa-replication-client replicate \
      --database="${DATABASE_URL}" \
      --replication-config="${cfg}" || echo "WARNING: Replication failed for $cfg"
  done
  echo "INFO: Replication finished at $(date)"
}

main() {
  wait_for_db
  while true; do
    execute_replication
    echo "INFO: Sleeping for ${DEFAULT_SYNC_PERIOD}s before next replication..."
    sleep "${DEFAULT_SYNC_PERIOD}"
  done
}

trap "exit 0" SIGINT SIGTERM
main
