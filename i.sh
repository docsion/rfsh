#!/bin/sh
set -e

echo "Hey @RUNFLOW_SH here!"
echo
RELEASES_URL="https://github.com/docsion/rfsh/releases"
FILE_BASENAME="runflow_sh"
LATEST="$(curl -sf https://raw.githubusercontent.com/docsion/rfsh/main/latest)"

if [[ -z "$VERSION" ]]; then
  VERSION="$LATEST"
fi

if [[ -z "$VERSION" ]]; then
  echo "[RFSH] Unable to get runflow version." >&2
  echo
  exit 1
fi

# Download
TMP_DIR="$(mktemp -d)"
trap "rm -rf \"$TMP_DIR\"" EXIT INT TERM
OS="$(uname -s)"
ARCH="$(uname -m)"
TAR_FILE="${FILE_BASENAME}_${OS}_${ARCH}.tar.gz"
echo "[RFSH] Downloading runflow $VERSION..."
echo
n=0
until [ "$n" -ge 3 ]; do
  curl -C - --retry 3 -sfLo "$TMP_DIR/$TAR_FILE" "$RELEASES_URL/download/$VERSION/$TAR_FILE" && break
  n=$((n+1))
  sleep 15
done
if [[ ! -a "$TMP_DIR/$TAR_FILE" ]]; then
  echo '[RFSH] Failed to download runflow'
exit
fi

# Install
tar -xf "$TMP_DIR/$TAR_FILE" -C "$TMP_DIR"
mv "$TMP_DIR/runflow_sh" ./runflow
echo "[RFSH] Runflow has been installed"
echo
echo "[RFSH] Done ✓" "$" $(pwd)/runflow
