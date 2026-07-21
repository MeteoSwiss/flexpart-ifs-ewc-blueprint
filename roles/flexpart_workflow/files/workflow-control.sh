#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${FLEXPART_INSTALL_DIR:-/opt/flexpart-ifs}"
cd "$INSTALL_DIR"

compose=(docker compose --env-file config/workflow.env -f compose.yml)

case "${1:-}" in
  config)
    "${compose[@]}" config
    ;;
  pull)
    "${compose[@]}" pull
    ;;
  start)
    "${compose[@]}" up -d orchestrator
    ;;
  stop)
    "${compose[@]}" down
    ;;
  status)
    "${compose[@]}" ps
    ;;
  logs)
    "${compose[@]}" logs --tail=200 "${2:-orchestrator}"
    ;;
  *)
    echo "Usage: $0 {config|pull|start|stop|status|logs [service]}" >&2
    exit 2
    ;;
esac
