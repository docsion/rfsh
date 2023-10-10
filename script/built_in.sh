
#!/bin/bash
#
# RFSH built-in functions.

#######################################
# Check require command
# Arguments:
#   Command, a string.
#   More info url, a string.
# Returns:
#   0 if command exist, 1 on error.
#######################################
rf_require() {
  cmd=$1
  more=$2
  if ! [ -x "$(command -v ${cmd})" ]; then
    msg="${cmd} is required."
    if [[ ! -z "${more}" ]]; then
	msg="${msg} More info: ${more}"
    fi
    rf_err ${msg}
  fi
}

#######################################
# Write log to stderror
# Arguments:
#   Log to show, a string.
# Returns:
#   Writes log to stderror, then return 1.
#######################################
rf_err() {
  echo "$*" >&2 # print to stderr
  exit 1
}

#######################################
# Assert equals between expected value and actual value
# Arguments:
#   Test case name, a string.
#   Expected value, any.
#   Actual value, any.
# Returns:
#   0 if equals, 1 on error.
#######################################
rf_asserts() {
  name=$1
  expect=$2
  actual=$3
  if [[ ! "${expect}" == "${actual}" ]];
  then
    rf_err Test \"${name}\" failed . Expect "${expect}". Actual "${actual}."
  fi
}

#######################################
# Get $RESULT_IN
# Globals:
#   RESULT_IN
# Arguments:
#   RESULT_IN, a string.
# Returns:
#   String if RESULT_IN exists, 1 on errors.
#######################################
rf_result_in() {
  if [[ -z $RESULT_IN ]];
  then
    rf_err "RESULT_IN is required"
  fi

  echo $RESULT_IN
}

#######################################
# Exec curl with -w "%{json}"
# Arguments:
#   Curl request likes, a string
# Returns:
#   Json -w "%{json}", a string.
#   1 on error.
#######################################
rf_curl() {
  rf_require curl https://github.com/curl/curl \
    && curl -o $(mktemp) -s -w "%{json}" "$@"
}

#######################################
# Exec http/https request, curl likes
# Arguments:
#   Curl request likes, a string
# Returns:
#   Json {response_code, response}.
#     - response_code: http response status code, a number, e.g. 200
#     - response: response content file location, a string
#   1 on error.
#######################################
rf_http() {
  rf_require jq https://github.com/jqlang/jq \
	&& rf_curl "$@" \
	  | jq '{"response_code": .response_code} + {"response": .filename_effective}'

  return_codes=( "${PIPESTATUS[@]}" )
  if (( return_codes[0] != 0 )); then
    exit ${return_codes[0]}
  fi
}

