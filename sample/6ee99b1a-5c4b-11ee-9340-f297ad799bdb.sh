#!/bin/sh
echo "[RFSH] Job 6ee99b1a-5c4b-11ee-9340-f297ad799bdb"
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM
# install runflow
pushd ${RUN_DIR} && \
	curl https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.1.8 sh && \
	popd
if [ ! -f ${RUN_DIR}/runflow ]; then
    echo "Runflow not found!"
fi
# --input
echo aWQsY29udGVudA0KMSx0aGUgbm9ybWFsDQoyLCJ3aXRoICwgY29tbWEiDQozLCJ3aXRoIAplbmQKbGluZSAiDQo0LCJ3aXRoICwgY29tbWEKZW5kCmxpbmUiDQo1LHRoZSB1dGY4IG7hu5lpIGR1bmcKNTkwNTgsdGhlIHJlYWwgY29udGVudCBpZAo1OTA1OCwicmVhbCBjb250ZW50IHdpdGggLCBjb21tYQplbmQKbGluZSINCjgsIlsiImPGoW0gdOG6pW0gMzBrIiIsIiJjxqFtIHThuqVtIHTDom4gcGjDuiIiXSIK | base64 --decode > ${RUN_DIR}/input
# --template
echo ZWNobyAiaGVsbG8gYmFzaCBydW5uZXIge3tpZH19IHt7Y29udGVudH19Igo= | base64 --decode > ${RUN_DIR}/template
${RUN_DIR}/runflow basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template -o sample.out.csv --concurrent 4 --retries 2
