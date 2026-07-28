#!/usr/bin/env bash
#
# Confirm the deployed site is actually serving the page.
#
# A Pages deploy reporting success only means the upload was accepted:
# the custom domain can still be serving something else, or nothing.
# This is also what the scheduled heartbeat runs, so a site that breaks
# long after its last deploy still gets noticed.
#
# Usage: scripts/check-live.sh [url] [attempts]

set -euo pipefail

URL="${1:-https://www.avishaikofun.com/}"
ATTEMPTS="${2:-10}"
RETRY_DELAY=20

# A 200 that serves the wrong thing is the failure this is here to catch,
# so match on something only this page contains.
EXPECT="Avishai Kofun"

body="$(mktemp)"
trap 'rm -f "$body"' EXIT

status=000
for attempt in $(seq 1 "$ATTEMPTS"); do
  # curl still prints %{http_code} (as 000) when it fails, so `|| echo`
  # would append a second code and report a nonsense "000000".
  status="$(curl -sS -o "$body" -w '%{http_code}' --max-time 10 "$URL" || true)"
  status="${status:-000}"

  if [ "$status" = "200" ] && grep -q "$EXPECT" "$body"; then
    echo "[check-live] ok: ${URL} serves the site"
    exit 0
  fi

  echo "[check-live] attempt ${attempt}/${ATTEMPTS}: status ${status}"
  if [ "$attempt" -lt "$ATTEMPTS" ]; then
    sleep "$RETRY_DELAY"
  fi
done

echo "::error::${URL} did not serve the site after ${ATTEMPTS} attempts (last status ${status})"
exit 1
