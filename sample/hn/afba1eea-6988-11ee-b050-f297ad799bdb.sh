#!/bin/bash
#
# RFSH Job
# Template version: #19a456a
# Ref: https://github.com/docsion/rfsh/blob/19a456a/script/job.sh.template

echo
echo "[RFSH] Job afba1eea-6988-11ee-b050-f297ad799bdb"
echo
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM

# install runflow
runflow_sh=runflow
if ! [ -x "$(command -v runflow)" ] || ! [[ "$(runflow version)" =~ "v0.3.0" ]]; then
  echo '[RFSH] Downloading runflow...'
  echo
  pushd ${RUN_DIR} > /dev/null 2>&1 && \
    n=0 && \
      until [ "$n" -ge 3 ]; do
      curl -C - --retry 3 -sL https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.3.0 sh && break
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
  echo [RFSH] Found runflow v0.3.0 at $(which runflow)
  echo
fi

# --input
echo '[RFSH] Building input...'
echo
echo aWQsdHlwZQ0KODg2MyxzdG9yeQ0KMjkyMTk4Myxjb21tZW50DQoxMjEwMDMsc3RvcnkNCjE5MjMyNyxqb2INCjEyNjgwOSxwb2xsDQo4ODYzLGZhaWxlZC1zdG9yeQ0K | base64 --decode > ${RUN_DIR}/input

# --template
echo '[RFSH] Building template...'
echo
echo Y3VybCAtbyAkKG1rdGVtcCkgLXMgLXcgIiV7anNvbn0iIGh0dHBzOi8vaGFja2VyLW5ld3MuZmlyZWJhc2Vpby5jb20vdjAvaXRlbS97e2lkfX0uanNvbiBcCgl8IGpxIC1jICd7InJlc3BvbnNlX2NvZGUiOiAucmVzcG9uc2VfY29kZX0gKyB7InJlc3BvbnNlIjogLmZpbGVuYW1lX2VmZmVjdGl2ZX0nCg== | base64 --decode > ${RUN_DIR}/template

# --test-template
echo '[RFSH] Building test template...'
echo
echo IyBSRVNVTFQgRlJPTSBTQ1JJUFQgUlVOUwojICRSRVNVTFRfSU4KCiMgaHR0cCBzdGF0dXMKdGVzdF9jYXNlPSJTdGF0dXMgMjAwIgppZiBbWyAhICIkKGVjaG8gJFJFU1VMVF9JTiB8IGpxICcucmVzcG9uc2VfY29kZScpIiA9PSAyMDAgXV07CnRoZW4KCWVjaG8gVGVzdCBcIiR7dGVzdF9jYXNlfVwiIGZhaWxlZCAuIEV4cGVjdCAyMDAuIEFjdHVhbCAiJChlY2hvICRSRVNVTFRfSU4gfCBqcSAnLnJlc3BvbnNlX2NvZGUnKSIgPiYyICMgcHJpbnQgdG8gc3RkZXJyCglleGl0IDE7CmZpCgojIGJvZHkgPiBpZAp0ZXN0X2Nhc2U9IklkIHt7aWR9fSIKaWYgW1sgISAkKGNhdCAkKGVjaG8gJFJFU1VMVF9JTiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxIC1yICcuaWQnKSA9PSB7e2lkfX0gXV07CnRoZW4KCWVjaG8gVGVzdCBcIiR7dGVzdF9jYXNlfVwiIGZhaWxlZCAuIEV4cGVjdCB7e2lkfX0uIEFjdHVhbCAkKGNhdCAkKGVjaG8gJFJFU1VMVF9JTiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxICcuaWQnKSA+JjIgIyBwcmludCB0byBzdGRlcnIKCWV4aXQgMTsKZmkKCiMgYm9keSA+IHR5cGUKdGVzdF9jYXNlPSJUeXBlIHt7dHlwZX19IgppZiBbWyAhICIkKGNhdCAkKGVjaG8gJFJFU1VMVF9JTiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxIC1yICcudHlwZScpIiA9PSAie3t0eXBlfX0iIF1dOwp0aGVuCgllY2hvIFRlc3QgXCIke3Rlc3RfY2FzZX1cIiBmYWlsZWQgLiBFeHBlY3Qge3t0eXBlfX0uIEFjdHVhbCAkKGNhdCAkKGVjaG8gJFJFU1VMVF9JTiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxIC1yICcudHlwZScpID4mMiAjIHByaW50IHRvIHN0ZGVycgoJZXhpdCAxOwpmaQo= | base64 --decode > ${RUN_DIR}/testtemplate

# --export-template
echo '[RFSH] Building exports template...'
echo
echo {{export_template_content}} | base64 --decode > ${RUN_DIR}/exporttemplate

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template --concurrent 4 --retries 0 --test-template ${RUN_DIR}/testtemplate
echo '[RFSH] Done'
