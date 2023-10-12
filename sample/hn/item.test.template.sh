# RESULT FROM SCRIPT RUNS
# $RESULT_IN

# http status
test_case="Status 200"
if [[ ! "$(echo $RESULT_IN | jq '.response_code')" == 200 ]];
then
	echo Test \"${test_case}\" failed . Expect 200. Actual "$(echo $RESULT_IN | jq '.response_code')" >&2 # print to stderr
	exit 1;
fi

# body > id
test_case="Id {{id}}"
if [[ ! $(cat $(echo $RESULT_IN | jq -r '.response') | jq -r '.id') == {{id}} ]];
then
	echo Test \"${test_case}\" failed . Expect {{id}}. Actual $(cat $(echo $RESULT_IN | jq -r '.response') | jq '.id') >&2 # print to stderr
	exit 1;
fi

# body > type
test_case="Type {{type}}"
if [[ ! "$(cat $(echo $RESULT_IN | jq -r '.response') | jq -r '.type')" == "{{type}}" ]];
then
	echo Test \"${test_case}\" failed . Expect {{type}}. Actual $(cat $(echo $RESULT_IN | jq -r '.response') | jq -r '.type') >&2 # print to stderr
	exit 1;
fi
