#!/bin/sh
set -e

echo
echo "Hey @RUNFLOW_SH here!"
echo
RELEASES_URL="https://github.com/docsion/rfsh/releases"
FILE_BASENAME="runflow_sh"
LATEST="$(curl -sf https://raw.githubusercontent.com/docsion/rfsh/main/latest)"

test -z "$VERSION" && VERSION="$LATEST"

test -z "$VERSION" && {
	echo "[RFSH] Unable to get runflow version." >&2
 	echo
	exit 1
}

TMP_DIR="$(mktemp -d)"
trap "rm -rf \"$TMP_DIR\"" EXIT INT TERM
OS="$(uname -s)"
ARCH="$(uname -m)"
TAR_FILE="${FILE_BASENAME}_${OS}_${ARCH}.tar.gz"

(
	cd "$TMP_DIR"
	echo "[RFSH] Downloading runflow $VERSION..."
 	echo
	curl -sfLO "$RELEASES_URL/download/$VERSION/$TAR_FILE"
)

tar -xf "$TMP_DIR/$TAR_FILE" -C "$TMP_DIR"
mv "$TMP_DIR/runflow_sh" ./runflow
echo "[RFSH] Done" $(pwd)/runflow
echo
