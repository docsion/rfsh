#!/bin/sh
echo
echo "[RFSH] Job be918dae-6113-11ee-815c-f297ad799bdb"
echo
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM

# install runflow
runflow_sh=runflow
if ! [ -x "$(command -v runflow)" ] || ! [[ "$(runflow version)" =~ "v0.2.1" ]]; then
  echo '[RFSH] Downloading runflow...'
  echo
  pushd ${RUN_DIR} > /dev/null 2>&1 && \
    n=0 && \
      until [ "$n" -ge 3 ]; do
      curl -C - --retry 3 -sL https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.2.1 sh && break
      n=$((n+1))
      sleep 15
      done && \
    popd > /dev/null 2>&1
  if [[ ! -a ${RUN_DIR}/runflow ]]; then
    echo '[*] Failed to download runflow. More info: https://github.com/docsion/rfsh'
    echo
    exit
  fi
  runflow_sh=${RUN_DIR}/runflow
else
  echo [RFSH] Found runflow v0.2.1 at $(which runflow)
  echo
fi

# --input
echo '[RFSH] Building input...'
echo
echo aWQsY29udGVudA0KMSx0aGUgbm9ybWFsDQoyLCJ3aXRoICwgY29tbWEiDQozLCJ3aXRoIAplbmQKbGluZSAiDQo0LCJ3aXRoICwgY29tbWEKZW5kCmxpbmUiDQo1LHRoZSB1dGY4IG7hu5lpIGR1bmcKNTkwNTgsdGhlIHJlYWwgY29udGVudCBpZAo1OTA1OCwicmVhbCBjb250ZW50IHdpdGggLCBjb21tYQplbmQKbGluZSINCjgsIlsiImPGoW0gdOG6pW0gMzBrIiIsIiJjxqFtIHThuqVtIHTDom4gcGjDuiIiXSIK | base64 --decode > ${RUN_DIR}/input

# --template
echo '[RFSH] Building temlate...'
echo
echo ZWNobyAiaGVsbG8gYmFzaCBydW5uZXIge3tpZH19IHt7Y29udGVudH19Igo= | base64 --decode > ${RUN_DIR}/template

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template -o sample.out.csv --concurrent 4 --retries 2
echo '[RFSH] Done'
