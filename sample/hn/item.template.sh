curl -o $(mktemp) -s -w "%{json}" https://hacker-news.firebaseio.com/v0/item/{{id}}.json \
	| jq '{"response_code": .response_code} + {"response": .filename_effective}'
