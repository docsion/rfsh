#!/bin/bash
#
# RFSH Job
# Template version: #19a456a
# Ref: https://github.com/docsion/rfsh/blob/19a456a/script/job.sh.template

echo
echo "[RFSH] Job 4411d688-6988-11ee-a507-f297ad799bdb"
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
echo aWQsY29udGVudCxwaGlsb3NvcGhlcg0KMSxJdCBkb2VzIG5vdCBtYXR0ZXIgaG93IHNsb3dseSB5b3UgZ28gYXMgbG9uZyBhcyB5b3UgZG8gbm90IHN0b3AsQ29uZnVjaXVzDQoyLCJRdWFsaXR5IGlzIG5vdCBhbiBhY3QsIGl0IGlzIGEgaGFiaXQiLEFyaXN0b3RsZQ0KMywiQWxsIG1hbmtpbmQuLi4gYmVpbmcgYWxsIGVxdWFsIGFuZCBpbmRlcGVuZGVudCwgbm8gb25lIG91Z2h0IHRvIGhhcm0gYW5vdGhlciBpbiBoaXMgbGlmZSwgaGVhbHRoLCBsaWJlcnR5IG9yIHBvc3Nlc3Npb25zIixKb2huIExvY2tlDQo0LCJIaXN0b3J5IHJlcGVhdHMgaXRzZWxmLCBmaXJzdCBhcyB0cmFnZWR5LCBzZWNvbmQgYXMgZmFyY2UiLEthcmwgTWFyeA0KNSwiVGhlIHdob2xlIHByb2JsZW0gd2l0aCB0aGUgd29ybGQgaXMgdGhhdCBmb29scyBhbmQgZmFuYXRpY3MgYXJlIGFsd2F5cyBzbyBjZXJ0YWluIG9mIHRoZW1zZWx2ZXMsIGFuZCB3aXNlciBwZW9wbGUgc28gZnVsbCBvZiBkb3VidHMiLEJlcnRyYW5kIFJ1c3NlbGwNCjYsIklmIHlvdSBhcmUgbG9uZWx5IHdoZW4geW91J3JlIGFsb25lLCB5b3UgYXJlIGluIGJhZCBjb21wYW55IixKZWFuLVBhdWwgU2FydHJlDQo3LEFsbCBtZW4ncyBtaXNlcmllcyBkZXJpdmUgZnJvbSBub3QgYmVpbmcgYWJsZSB0byBzaXQgaW4gYSBxdWlldCByb29tIGFsb25lLEJsYWlzZSBQYXNjYWwNCjgsVGhlcmUgaXMgbm8gZ3JlYXRlciB0eXJhbm55IHRoYW4gdGhhdCB3aGljaCBpcyBwZXJwZXRyYXRlZCB1bmRlciB0aGUgc2hpZWxkIG9mIHRoZSBsYXcgYW5kIGluIHRoZSBuYW1lIG9mIGp1c3RpY2UsTW9udGVzcXVpZXUNCjksQmVhdXR5IGluIHRoaW5ncyBleGlzdHMgaW4gdGhlIG1pbmQgd2hpY2ggY29udGVtcGxhdGVzIHRoZW0sRGF2aWQgSHVtZQ0KMTAsIkxldCBjb21lIHdoYXQgY29tZXMsIGxldCBnbyB3aGF0IGdvZXMuIFNlZSB3aGF0IHJlbWFpbnMiLFJhbWFuYSBNYWhhcnNoaQ0K | base64 --decode > ${RUN_DIR}/input

# --template
echo '[RFSH] Building template...'
echo
echo ZWNobyBOby4ge3tpZH19ICJcInt7Y29udGVudH19XCIiIC0ge3twaGlsb3NvcGhlcn19Cg== | base64 --decode > ${RUN_DIR}/template

# --test-template
echo '[RFSH] Building test template...'
echo
echo {{test_template_content}} | base64 --decode > ${RUN_DIR}/testtemplate

# --export-template
echo '[RFSH] Building exports template...'
echo
echo {{export_template_content}} | base64 --decode > ${RUN_DIR}/exporttemplate

# run
echo '[RFSH] Running job...'
echo
${runflow_sh} basic -i ${RUN_DIR}/input -t ${RUN_DIR}/template --concurrent 4 --retries 0
echo '[RFSH] Done'
