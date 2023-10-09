#!/bin/sh
echo
echo "[RFSH] Job 827c2d38-6695-11ee-9663-f297ad799bdb"
echo
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM

# install runflow
runflow_sh=runflow
if ! [ -x "$(command -v runflow)" ] || ! [[ "$(runflow version)" =~ "v0.2.6" ]]; then
  echo '[RFSH] Downloading runflow...'
  echo
  pushd ${RUN_DIR} > /dev/null 2>&1 && \
    n=0 && \
      until [ "$n" -ge 3 ]; do
      curl -C - --retry 3 -sL https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.2.6 sh && break
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
  echo [RFSH] Found runflow v0.2.6 at $(which runflow)
  echo
fi

# --input
echo '[RFSH] Building input...'
echo
echo aWQsdHlwZQ0KODg2MyxzdG9yeQ0KMjkyMTk4Myxjb21tZW50DQoxMjEwMDMsc3RvcnkNCjE5MjMyNyxqb2INCjEyNjgwOSxwb2xsDQo4ODYzLGZhaWxlZC1zdG9yeQ0K | base64 --decode > ${RUN_DIR}/input

# --template
echo '[RFSH] Building template...'
echo
echo Y3VybCAtbyAkKG1rdGVtcCkgLXMgLXcgIiV7anNvbn0iIGh0dHBzOi8vaGFja2VyLW5ld3MuZmlyZWJhc2Vpby5jb20vdjAvaXRlbS97e2lkfX0uanNvbiBcCgl8IGpxICd7InJlc3BvbnNlX2NvZGUiOiAucmVzcG9uc2VfY29kZX0gKyB7InJlc3BvbnNlIjogLmZpbGVuYW1lX2VmZmVjdGl2ZX0nCg== | base64 --decode > ${RUN_DIR}/template

# --test-template
echo '[RFSH] Building test template...'
echo
echo QkFTRTY0X1JFU1VMVF9JTj0kKGNhdCkgIyBSRVNVTFQgRlJPTSBTQ1JJUFQgUlVOUwoKIyBERUNPREUgQkVGT1JFIFVTSU5HICRlY2hvICRCQVNFNjRfUkVTVUxUX0lOIHwgYmFzZTY0IC0tZGVjb2RlClJFU1VMVF9JTj0kKGVjaG8gJEJBU0U2NF9SRVNVTFRfSU4gfCBiYXNlNjQgLS1kZWNvZGUpCgojIFRFU1QgQkVHSU4gSEVSRSEKIyBodHRwIHN0YXR1cwp0ZXN0X2Nhc2U9IlN0YXR1cyAyMDAiCmlmIFtbICEgIiQoZWNobyAkUkVTVUxUX0lOIHwganEgJy5yZXNwb25zZV9jb2RlJykiID09IDIwMCBdXTsKdGhlbgoJZWNobyBUZXN0IFwiJHt0ZXN0X2Nhc2V9XCIgZmFpbGVkIC4gRXhwZWN0IDIwMC4gQWN0dWFsICIkKGVjaG8gJFJFU1VMVF9JTiB8IGpxICcucmVzcG9uc2VfY29kZScpIiA+JjIgIyBwcmludCB0byBzdGRlcnIKCWV4aXQgMTsKZmkKCiMgYm9keSA+IGlkCnRlc3RfY2FzZT0iSWQge3tpZH19IgppZiBbWyAhICQoY2F0ICQoZWNobyAkUkVTVUxUX0lOIHwganEgLXIgJy5yZXNwb25zZScpIHwganEgLXIgJy5pZCcpID09IHt7aWR9fSBdXTsKdGhlbgoJZWNobyBUZXN0IFwiJHt0ZXN0X2Nhc2V9XCIgZmFpbGVkIC4gRXhwZWN0IHt7aWR9fS4gQWN0dWFsICQoY2F0ICQoZWNobyAkUkVTVUxUX0lOIHwganEgLXIgJy5yZXNwb25zZScpIHwganEgJy5pZCcpID4mMiAjIHByaW50IHRvIHN0ZGVycgoJZXhpdCAxOwpmaQoKIyBib2R5ID4gdHlwZQp0ZXN0X2Nhc2U9IlR5cGUge3t0eXBlfX0iCmlmIFtbICEgIiQoY2F0ICQoZWNobyAkUkVTVUxUX0lOIHwganEgLXIgJy5yZXNwb25zZScpIHwganEgLXIgJy50eXBlJykiID09ICJ7e3R5cGV9fSIgXV07CnRoZW4KCWVjaG8gVGVzdCBcIiR7dGVzdF9jYXNlfVwiIGZhaWxlZCAuIEV4cGVjdCB7e3R5cGV9fS4gQWN0dWFsICQoY2F0ICQoZWNobyAkUkVTVUxUX0lOIHwganEgLXIgJy5yZXNwb25zZScpIHwganEgLXIgJy50eXBlJykgPiYyICMgcHJpbnQgdG8gc3RkZXJyCglleGl0IDE7CmZpCg== | base64 --decode > ${RUN_DIR}/testtemplate

# --export-template
echo '[RFSH] Building exports template...'
echo
echo {{export_template_content}} | base64 --decode > ${RUN_DIR}/exporttemplate

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template --concurrent 4 --retries 0 --test-template ${RUN_DIR}/testtemplate
echo '[RFSH] Done'
