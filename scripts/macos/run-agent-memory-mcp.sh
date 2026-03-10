#!/usr/bin/env bash
set -euo pipefail

if [ -z "${MEMORY_DB_PATH:-}" ]; then
  printf "%s\n" "MEMORY_DB_PATH is required" >&2
  exit 1
fi

mkdir -p "$MEMORY_DB_PATH"

if [ "${ENABLE_HARDCOPY:-false}" = "true" ] && [ -n "${HARDCOPY_PATH:-}" ]; then
  mkdir -p "$HARDCOPY_PATH"
fi

exec agent-memory-mcp
