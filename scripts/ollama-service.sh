#!/usr/bin/env bash
# Configure the Homebrew Ollama service for the nvim AI plugins.
#
# minuet-ai (qwen2.5-coder:1.5b, FIM completions) and codecompanion (chat
# model) both talk to Ollama, so the service needs to keep more than one
# model resident and hold them past the 5 minute default keep-alive.
#
# Homebrew regenerates the launchd plist on `brew upgrade ollama`, wiping
# any EnvironmentVariables added to it. This script is idempotent: re-run
# it after every upgrade to restore the settings.
#
# Usage: scripts/ollama-service.sh [model ...]
#   Any models passed as arguments are warmed (loaded) after the restart.
#   Defaults to the models used by lua/minuet-config.lua and
#   lua/nvim-codecompanion.lua.
set -euo pipefail

KEEP_ALIVE="${OLLAMA_KEEP_ALIVE:-4h}"
MAX_LOADED="${OLLAMA_MAX_LOADED_MODELS:-2}"
if [[ $# -gt 0 ]]; then
  WARM_MODELS=("$@")
else
  WARM_MODELS=("qwen2.5-coder:1.5b" "qwen3.6:35b-a3b-nvfp4" "qwen2.5-coder:1.5b-base")
fi

PLIST="$(brew --prefix)/opt/ollama/homebrew.mxcl.ollama.plist"
PB=/usr/libexec/PlistBuddy

if [[ ! -f "$PLIST" ]]; then
  echo "error: $PLIST not found. Is ollama installed via Homebrew?" >&2
  exit 1
fi

# Probe with Print before Add/Set; PlistBuddy errors on missing keys,
# so the stderr redirect is load-bearing here.
set_env() {
  local key=$1 value=$2
  if "$PB" -c "Print :EnvironmentVariables:${key}" "$PLIST" >/dev/null 2>&1; then
    "$PB" -c "Set :EnvironmentVariables:${key} ${value}" "$PLIST"
  else
    "$PB" -c "Add :EnvironmentVariables:${key} string ${value}" "$PLIST"
  fi
  echo "  ${key}=${value}"
}

"$PB" -c "Print :EnvironmentVariables" "$PLIST" >/dev/null 2>&1 \
  || "$PB" -c "Add :EnvironmentVariables dict" "$PLIST"

echo "Configuring ${PLIST}:"
set_env OLLAMA_KEEP_ALIVE "$KEEP_ALIVE"
set_env OLLAMA_MAX_LOADED_MODELS "$MAX_LOADED"
# Re-applied here so they survive brew upgrades along with the rest.
set_env OLLAMA_FLASH_ATTENTION 1
set_env OLLAMA_KV_CACHE_TYPE q8_0

echo "Restarting ollama service..."
brew services restart ollama

# Wait for the server to come back before warming models.
for _ in $(seq 1 30); do
  if curl -sf http://localhost:11434/api/version >/dev/null; then
    break
  fi
  sleep 1
done
if ! curl -sf http://localhost:11434/api/version >/dev/null; then
  echo "error: ollama did not come back after restart. Check $(brew --prefix)/var/log/ollama.log" >&2
  exit 1
fi

# An empty generate request loads the model with the server's keep-alive.
for model in "${WARM_MODELS[@]}"; do
  echo "Warming ${model}..."
  curl -sf http://localhost:11434/api/generate -d "{\"model\": \"${model}\"}" >/dev/null \
    || echo "warning: could not load ${model} (not pulled yet?)" >&2
done

echo
ollama ps
