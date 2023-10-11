#!/bin/bash
#
# RFSH Job
# Template version: #19a456a
# Ref: https://github.com/docsion/rfsh/blob/19a456a/script/job.sh.template

echo
echo "[RFSH] Job 48b9b062-6824-11ee-84b6-f297ad799bdb"
echo
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM

# install runflow
runflow_sh=runflow
if ! [ -x "$(command -v runflow)" ] || ! [[ "$(runflow version)" =~ "v0.2.9" ]]; then
  echo '[RFSH] Downloading runflow...'
  echo
  pushd ${RUN_DIR} > /dev/null 2>&1 && \
    n=0 && \
      until [ "$n" -ge 3 ]; do
      curl -C - --retry 3 -sL https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.2.9 sh && break
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
  echo [RFSH] Found runflow v0.2.9 at $(which runflow)
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
echo IyBSRVNVTFQgRlJPTSBTQ1JJUFQgUlVOUwojICRSRVNVTFRfSU4KCiMgVEVTVCBCRUdJTiBIRVJFIQojIGh0dHAgc3RhdHVzCnRlc3RfY2FzZT0iU3RhdHVzIDIwMCIKaWYgW1sgISAiJChlY2hvICRSRVNVTFRfSU4gfCBqcSAnLnJlc3BvbnNlX2NvZGUnKSIgPT0gMjAwIF1dOwp0aGVuCgllY2hvIFRlc3QgXCIke3Rlc3RfY2FzZX1cIiBmYWlsZWQgLiBFeHBlY3QgMjAwLiBBY3R1YWwgIiQoZWNobyAkUkVTVUxUX0lOIHwganEgJy5yZXNwb25zZV9jb2RlJykiID4mMiAjIHByaW50IHRvIHN0ZGVycgoJZXhpdCAxOwpmaQoKIyBib2R5ID4gaWQKdGVzdF9jYXNlPSJJZCB7e2lkfX0iCmlmIFtbICEgJChjYXQgJChlY2hvICRSRVNVTFRfSU4gfCBqcSAtciAnLnJlc3BvbnNlJykgfCBqcSAtciAnLmlkJykgPT0ge3tpZH19IF1dOwp0aGVuCgllY2hvIFRlc3QgXCIke3Rlc3RfY2FzZX1cIiBmYWlsZWQgLiBFeHBlY3Qge3tpZH19LiBBY3R1YWwgJChjYXQgJChlY2hvICRSRVNVTFRfSU4gfCBqcSAtciAnLnJlc3BvbnNlJykgfCBqcSAnLmlkJykgPiYyICMgcHJpbnQgdG8gc3RkZXJyCglleGl0IDE7CmZpCgojIGJvZHkgPiB0eXBlCnRlc3RfY2FzZT0iVHlwZSB7e3R5cGV9fSIKaWYgW1sgISAiJChjYXQgJChlY2hvICRSRVNVTFRfSU4gfCBqcSAtciAnLnJlc3BvbnNlJykgfCBqcSAtciAnLnR5cGUnKSIgPT0gInt7dHlwZX19IiBdXTsKdGhlbgoJZWNobyBUZXN0IFwiJHt0ZXN0X2Nhc2V9XCIgZmFpbGVkIC4gRXhwZWN0IHt7dHlwZX19LiBBY3R1YWwgJChjYXQgJChlY2hvICRSRVNVTFRfSU4gfCBqcSAtciAnLnJlc3BvbnNlJykgfCBqcSAtciAnLnR5cGUnKSA+JjIgIyBwcmludCB0byBzdGRlcnIKCWV4aXQgMTsKZmkK | base64 --decode > ${RUN_DIR}/testtemplate

# --export-template
echo '[RFSH] Building exports template...'
echo
echo {{export_template_content}} | base64 --decode > ${RUN_DIR}/exporttemplate

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template --concurrent 4 --retries 0 --test-template ${RUN_DIR}/testtemplate
echo '[RFSH] Done'
