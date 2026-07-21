#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${FLEXPART_INSTALL_DIR:-/opt/flexpart-ifs}"
DATA_DIR="${FLEXPART_DATA_DIR:-/var/lib/flexpart-ifs}"
LOG_DIR="${FLEXPART_LOG_DIR:-/var/log/flexpart-ifs}"

failures=0

check() {
  local description="$1"
  shift
  if "$@" >/dev/null 2>&1; then
    printf '[OK]   %s\n' "$description"
  else
    printf '[FAIL] %s\n' "$description"
    failures=$((failures + 1))
  fi
}

check "Docker is installed" command -v docker
check "Docker daemon is available" docker info
check "Docker Compose plugin is available" docker compose version
check "Compose file exists" test -f "$INSTALL_DIR/compose.yml"
check "Workflow configuration exists" test -f "$INSTALL_DIR/config/workflow.yml"
check "Secrets file exists" test -f "$INSTALL_DIR/config/secrets.env"
check "Data directory exists" test -d "$DATA_DIR"
check "Log directory exists" test -d "$LOG_DIR"

if grep -Rqs 'REPLACE_BEFORE_DEPLOYMENT' \
  "$INSTALL_DIR/compose.yml" "$INSTALL_DIR/config/workflow.yml"; then
  printf '[WARN] Deployment placeholders are still present.\n'
fi

available_kb=$(df -Pk "$DATA_DIR" | awk 'NR==2 {print $4}')
if [[ "${available_kb:-0}" -lt 10485760 ]]; then
  printf '[WARN] Less than 10 GiB is available under %s.\n' "$DATA_DIR"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\nValidation failed with %s error(s).\n' "$failures"
  exit 1
fi

printf '\nBase environment validation passed.\n'
