#
# Use built-in functions
# rf_asserts
#   |- https://github.com/docsion/rfsh/blob/94c245d/script/built_in.sh#L46
# rf_result_in
#  |- https://github.com/docsion/rfsh/blob/94c245d/script/built_in.sh#L65

# TEST BEGIN HERE!
# http status
rf_asserts "Status 200" \
	200 \
	$(rf_result_in | jq -r '.response_code')

# body > id
rf_asserts "Id {{id}}" \
	{{id}} \
	$(cat $(rf_result_in | jq -r '.response') | jq -r '.id')

# body > type
rf_asserts "Type {{type}}" \
	{{type}} \
	$(cat $(rf_result_in | jq -r '.response') | jq -r '.type')
