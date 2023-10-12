#
# Use built-in functions
# rf_result_in
#  |- https://github.com/docsion/rfsh/blob/b416f5c/script/built_in.sh#L67
value=$(cat $(rf_result_in | jq -r '.good' | jq -r '.response') | jq -r '.file')
echo '{"file": "'$value'"}'
