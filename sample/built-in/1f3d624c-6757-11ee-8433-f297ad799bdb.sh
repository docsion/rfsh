#!/bin/sh
echo
echo "[RFSH] Job 1f3d624c-6757-11ee-8433-f297ad799bdb"
echo
RUN_DIR="$(mktemp -d)"
trap "rm -rf \"$RUN_DIR\"" EXIT INT TERM

# install runflow
runflow_sh=runflow
if ! [ -x "$(command -v runflow)" ] || ! [[ "$(runflow version)" =~ "v0.2.8" ]]; then
  echo '[RFSH] Downloading runflow...'
  echo
  pushd ${RUN_DIR} > /dev/null 2>&1 && \
    n=0 && \
      until [ "$n" -ge 3 ]; do
      curl -C - --retry 3 -sL https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | VERSION=v0.2.8 sh && break
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
  echo [RFSH] Found runflow v0.2.8 at $(which runflow)
  echo
fi

# --input
echo '[RFSH] Building input...'
echo
echo aWQsdHlwZQ0KODg2MyxzdG9yeQ0KMjkyMTk4Myxjb21tZW50DQoxMjEwMDMsc3RvcnkNCjE5MjMyNyxqb2INCjEyNjgwOSxwb2xsDQo4ODYzLGZhaWxlZC1zdG9yeQ0K | base64 --decode > ${RUN_DIR}/input

# --template
echo '[RFSH] Building template...'
echo
echo IyAKIyBVc2UgYnVpbHQtaW4gZnVuY3Rpb25zCiMgcmZfaHR0cAojICAgfC0gaHR0cHM6Ly9naXRodWIuY29tL2RvY3Npb24vcmZzaC9ibG9iLzk0YzI0NWQvc2NyaXB0L2J1aWx0X2luLnNoI0w5NwoKcmZfaHR0cCBodHRwczovL2hhY2tlci1uZXdzLmZpcmViYXNlaW8uY29tL3YwL2l0ZW0ve3tpZH19Lmpzb24KCg== | base64 --decode > ${RUN_DIR}/template

# --test-template
echo '[RFSH] Building test template...'
echo
echo IwojIFVzZSBidWlsdC1pbiBmdW5jdGlvbnMKIyByZl9hc3NlcnRzCiMgICB8LSBodHRwczovL2dpdGh1Yi5jb20vZG9jc2lvbi9yZnNoL2Jsb2IvOTRjMjQ1ZC9zY3JpcHQvYnVpbHRfaW4uc2gjTDQ2CiMgcmZfcmVzdWx0X2luCiMgIHwtIGh0dHBzOi8vZ2l0aHViLmNvbS9kb2NzaW9uL3Jmc2gvYmxvYi85NGMyNDVkL3NjcmlwdC9idWlsdF9pbi5zaCNMNjUKCiMgVEVTVCBCRUdJTiBIRVJFIQojIGh0dHAgc3RhdHVzCnJmX2Fzc2VydHMgIlN0YXR1cyAyMDAiIFwKCTIwMCBcCgkkKHJmX3Jlc3VsdF9pbiB8IGpxIC1yICcucmVzcG9uc2VfY29kZScpCgojIGJvZHkgPiBpZApyZl9hc3NlcnRzICJJZCB7e2lkfX0iIFwKCXt7aWR9fSBcCgkkKGNhdCAkKHJmX3Jlc3VsdF9pbiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxIC1yICcuaWQnKQoKIyBib2R5ID4gdHlwZQpyZl9hc3NlcnRzICJUeXBlIHt7dHlwZX19IiBcCgl7e3R5cGV9fSBcCgkkKGNhdCAkKHJmX3Jlc3VsdF9pbiB8IGpxIC1yICcucmVzcG9uc2UnKSB8IGpxIC1yICcudHlwZScpCg== | base64 --decode > ${RUN_DIR}/testtemplate

# --export-template
echo '[RFSH] Building exports template...'
echo
echo {{export_template_content}} | base64 --decode > ${RUN_DIR}/exporttemplate

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template --concurrent 4 --retries 0 --test-template ${RUN_DIR}/testtemplate
echo '[RFSH] Done'
