#!/bin/bash
#
# RFSH sample tests
# Home: https://github.com/docsion/rfsh

set -euo pipefail

runflow=${1:-runflow}

echo "Hey @RUNFLOW_SH here!"
echo

echo
echo "[*] Echo"
echo
echo $ runflow basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv
echo
${runflow} basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv \
  && echo "sample/sample.out.csv" \
  && mlr --icsv --opprint --from sample/sample.out.csv put '$content = $content[:10] . "..."; $RFSH_good = $RFSH_good[:100] . ""'


echo
echo "[*] Hackernews API Test"
echo "|-without -o"
echo
echo $ runflow basic -i sample/hn/items.csv -t sample/hn/item.template.sh --test-template sample/hn/item.test.template.sh -o sample/hn/item.out.csv
echo
${runflow} basic -i sample/hn/items.csv -t sample/hn/item.template.sh --test-template sample/hn/item.test.template.sh -o sample/hn/item.out.csv \
  && echo "sample/hn/item.out.csv" \
  && mlr --icsv --opprint --from sample/hn/item.out.csv put '$RFSH_good = $RFSH_good[:50] . "..."'

echo
echo "[*] Built-in Functions"
echo "|-with rf_http, rf_asserts in built-in functions"
echo
echo $ runflow basic -i sample/built-in/items.csv -t sample/built-in/item.template.sh --test-template sample/built-in/item.test.template.sh -o sample/built-in/item.out.csv
echo
${runflow} basic -i sample/built-in/items.csv -t sample/built-in/item.template.sh --test-template sample/built-in/item.test.template.sh -o sample/built-in/item.out.csv

echo
echo "[*] Report Steam Telegram"
echo "|-with --retries, --report-remote-stream, --report-telegram-token, --report-telegram-channel"
echo
echo $ runflow basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv --retries 2 --report-remote-stream telegram --report-telegram-token 5843350735:AAHfE27GU6Y0Oq6n7kKiMTJVATYS1AQMDgU --report-telegram-channel @rfsh_report
echo 
${runflow} basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv --retries 2 --report-remote-stream telegram --report-telegram-token 5843350735:AAHfE27GU6Y0Oq6n7kKiMTJVATYS1AQMDgU --report-telegram-channel @rfsh_report

echo
echo "[*] Meme"
echo "|-with --meme, --auth-phrase"
echo
echo $ runflow --auth-phrase senator-handwash-daybed --meme basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv
echo
${runflow} --auth-phrase senator-handwash-daybed --meme basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv

echo
echo "[*] Coffee"
echo "|-with -i std"
echo
echo "\$ echo \"0\\\n1\\\n2\\\n3\\\n4\\\n5\" | runflow basic -t sample/coffee/get.template.sh --export-template sample/coffee/export.template.sh -o sample/coffee/get.out.csv"
echo
echo "0\n1\n2\n3\n4\n5" \
  | ${runflow} basic -t sample/coffee/get.template.sh --export-template sample/coffee/export.template.sh -o sample/coffee/get.out.csv \
    && echo "sample/coffee/get.out.csv" \
    && mlr --icsv --opprint cut -f 0,RFSH_export_file sample/coffee/get.out.csv \
    && echo "file" \
    && mlr --icsv --ojson cut -f RFSH_export_file sample/coffee/get.out.csv \
      | jq -r ".[].RFSH_export_file" \
      | xargs imgcat -W 250px -p -u

echo
echo "[*] Rate limit"
echo
echo $ runflow basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv --rate-limit 10,10
echo
${runflow} basic -t sample/sample.template -i sample/sample.csv -o sample/sample.out.csv --rate-limit 10,10

echo
echo "[*] Export with dry-run"
echo
echo "\$ echo \"0\\\n1\\\n2\\\n3\\\n4\\\n5\" | runflow basic -t sample/coffee/get.template.sh --export-template sample/coffee/export.template.sh -o sample/coffee/get.out.csv --dry-run"
echo
echo "0\n1\n2\n3\n4\n5" \
  | ${runflow} basic -t sample/coffee/get.template.sh --export-template sample/coffee/export.template.sh -o sample/coffee/get.dry.out.csv --dry-run \
    && echo "sample/coffee/get.out.csv" \
    && mlr --icsv --opprint cut -f 0,RFSH_script,RFSH_test_script,RFSH_export_script sample/coffee/get.dry.out.csv
