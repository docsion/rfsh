#!/bin/sh
set -e

echo "Hey @RUNFLOW_SH here!"
RELEASES_URL="https://github.com/docsion/rfsh/releases"
FILE_BASENAME="runflow_sh"
LATEST="$(curl -sf https://raw.githubusercontent.com/docsion/rfsh/main/latest)"

test -z "$VERSION" && VERSION="$LATEST"

test -z "$VERSION" && {
	echo "Unable to get runflow_sh version." >&2
	exit 1
}

TMP_DIR="$(mktemp -d)"
# shellcheck disable=SC2064 # intentionally expands here
trap "rm -rf \"$TMP_DIR\"" EXIT INT TERM
OS="$(uname -s)"
ARCH="$(uname -m)"
# test "$ARCH" = "aarch64" && ARCH="arm64"
TAR_FILE="${FILE_BASENAME}_${OS}_${ARCH}.tar.gz"

(
	cd "$TMP_DIR"
	echo "Downloading runflow_sh $VERSION..."
	curl -sfLO "$RELEASES_URL/download/$VERSION/$TAR_FILE"
)

tar -xf "$TMP_DIR/$TAR_FILE" -C "$TMP_DIR"
"$TMP_DIR/runflow_sh" "$@"
