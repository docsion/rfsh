<a href="https://github.com/docsion/rfsh">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/docsion/rfsh/blob/main/static/rfsh_banner_v6_dark.png">
    <source media="(prefers-color-scheme: light)" srcset="https://github.com/docsion/rfsh/blob/main/static/rfsh_banner_v6.png">
    <img alt="RFSH: Supercharge your shell scripts - Running shell scripts in batch, concurrently, fully customized with variable ." src="https://github.com/docsion/rfsh/blob/main/static/rfsh_banner_v6.png">
  </picture>

  <h1 align="left">RFSH</h1>
</a>

[![Releases](https://img.shields.io/github/v/release/docsion/rfsh.svg?style=flat?maxAge=86400)](https://github.com/docsion/rfsh/releases)
[![Downloads](https://img.shields.io/github/downloads/docsion/rfsh/total?maxAge=3600)](https://github.com/docsion/rfsh#install)

> @RUNFLOW_SH

<p align="left">
  Supercharge your shell scripts - Run shell scripts in batch, concurrently, fully customized with variable .
</p>


## What is it?
At the first point of view, I want to create a tool which can help our team run the bash script easier, faster, safer, with clearly reports, so I build RFSH.

To me, the first ability of good software is privacy matter. I want to create a good software and I don't want to make rich by charging on things running on your own resources (your computer, your server, your cloud,...). So basically, RFSH will be free-forever for usage.

You put a .csv file, a bash script as a template file, RFSH will take care the rest, then you will receive the clearly reports after all. Things happen on your machine, safe and sound.

## How it works?
RFSH works by 3 simple steps:
1. Parse your .csv file to a list of variable and its value, `variable_name` defined at the first row of the .csv file.
2. Combine value + template file, by `{{variable_name}}` matching, to scripts.
3. Run scripts concurrently.

## Features
1. Concurrently run a template with values from a CSV file, url, github, google spreadsheets.
2. Generate an all-in-one job file which contains input data, template script, command flags that can run anywhere.
3. Send reports to remotely stream. Support: telegram.
4. Customize the exports .csv file.
5. Test runs result with template script.
6. Show meme at the end of reports \ **supercharge** / 💅

## Sample
### Basic
Run the following script to execute the basic sample. You can find the script, input data, template at [sample](https://github.com/docsion/rfsh/tree/main/sample):
 ```
curl https://raw.githubusercontent.com/docsion/rfsh/main/sample/7ec342c2-636a-11ee-a33f-f297ad799bdb.sh | sh
#
# |- generated by:
# |- $runflow --generate-job basic -i https://github.com/docsion/rfsh/blob/main/sample/sample.csv -t https://github.com/docsion/rfsh/blob/main/sample/sample.template
```

Output:
 ```
[RFSH] 2023/10/04 - 16:01:22 |       RUN  |    111µs |    0% |       0 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |    110µs |    0% |       0 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |    102µs |    0% |       0 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |    111µs |    0% |       0 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      3ms |   12% |       1 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |      3ms |   25% |       2 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |      3ms |   25% |       2 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      3ms |   25% |       2 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |      4ms |   38% |       3 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      4ms |   38% |       3 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      5ms |   50% |       4 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |       RUN  |      5ms |   50% |       4 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      7ms |   62% |       5 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      7ms |   75% |       6 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      8ms |   88% |       7 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |      GOOD  |      8ms |  100% |       8 ✓  |       0 𐄂  |      0 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] 2023/10/04 - 16:01:22 |    REPORT  |      8ms |  100% |       8 ✓  |       0 𐄂  |      0 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/1750217848.csv

[RFSH] Done
```

### Hackernews APIs Test
You can find the script, input data, template at [sample/hn](https://github.com/docsion/rfsh/tree/main/sample/hn):
 ```
curl https://raw.githubusercontent.com/docsion/rfsh/main/sample/hn/827c2d38-6695-11ee-9663-f297ad799bdb.sh | sh
#
# |- generated by:
# |- $runflow --generate-job basic -i https://github.com/docsion/rfsh/blob/main/sample/hn/items.csv -t https://github.com/docsion/rfsh/blob/main/sample/hn/item.template.sh --test-template https://github.com/docsion/rfsh/blob/main/sample/hn/item.test.template.sh
```
Output:
 ```
[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    206µs |    0% |       0 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    218µs |    0% |       0 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    217µs |    0% |       0 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    217µs |    0% |       0 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |      GOOD  |    706ms |   17% |       1 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    709ms |   33% |       2 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |      GOOD  |    709ms |   33% |       2 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |      GOOD  |    719ms |   50% |       3 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |       RUN  |    720ms |   67% |       4 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:54 |      GOOD  |    720ms |   67% |       4 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:55 |      GOOD  |       1s |   83% |       5 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] 2023/10/09 - 18:20:55 |       BAD  |       1s |  100% |       5 ✓  |       1 𐄂  |      0 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv
Test "Type failed-story" failed . Expect failed-story. Actual story
exit status 1

[RFSH] 2023/10/09 - 18:20:55 |    REPORT  |       1s |  100% |       5 ✓  |       1 𐄂  |      0 ‣ |      0 ↩︎ | /var/folders/f7/nj7_1pc15mj0st_k9vyq2yl80000gn/T/374584017.csv

[RFSH] Done
```

## Install
Run the following install script to install the latest version of RFSH:
```
curl https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | sh
```

## Command

### help
```
$ ./runflow help
runflow - Supercharge your shell scripts - Run shell scripts in batch, concurrently, fully customized with variable .
Usage: runflow [options...] command [options...]

Commands:
   basic    Execute a basic flow .
   version  Show the version .

Options:
   --generate-job       Generate an all-in-one job file which contains input data, template script, command flags that can run anywhere .
   --auth-phrase value  Provide an auth phrase to automatically authenticate the running flow as your *supercharge* .
   --built-in           Print built-in functions .
   --meme               *Supercharge* Show meme at the end of reports .

Author:
   Beast. D <beast@docsion.com>

Copyright:
   (c) 2023 Docsion Team .
```

### basic
```
$ ./runflow basic
runflow basic - Execute a basic flow .
Usage: runflow basic [options...]

Description:
   Concurrently run a template with values from a CSV file .
   Example: $runflow basic -i sample.csv -t sample.template
   More info: https://github.com/docsion/rfsh#sample

Options:
   --input file, -i file            CSV file with values in comma-separated format. Headers define variable_name(s). Support: file, url (http/https), github, spreadsheets .
   --template file, -t file         Location of the template file. Variables are in the format {{variable_name}}. Support: file, url (http/https), github .
   --output file, -o file           Location of the export file .
   --test-template file             Location of the test template file, which use to validate running result. More info: https://github.com/docsion/rfsh#--test-template .
   --export-template file           Location of the export template file, which use to customize output file. More info: https://github.com/docsion/rfsh#--export-template .
   --concurrent value               Number of concurrent workers . (default: 4)
   --retries value                  Number of retries on failure . (default: 0)
   --dry-run                        Only print the script to --output that would execute, without executing it .
   --report-remote-stream value     Send reports to remotely stream. Support: telegram .
   --report-telegram-token value    Telegram Bot Token. More info: https://github.com/docsion/rfsh#telegram .
   --report-telegram-channel value  Telegram channel .
```

## Flag

### --test-template
You can write test with --test-template. Runflow will pass the result as input data (stdin) to your test template file after running script. Please note that, the input result is base64 encoded as default. Use `exit` command to mark the result as bad. You can also retrive the variable with format `{{variable_name}}` .

Run the following job script to explore how it works:
 ```
curl https://raw.githubusercontent.com/docsion/rfsh/main/sample/30969f5a-6369-11ee-a32e-f297ad799bdb.sh | sh
#
# |- generated by:
# |- $runflow --generate-job basic -i sample/sample.csv -t sample/sample.template --test-template sample/sample.test.template --export-template sample/sample.export.template
```

You can find sample test at [sample/sample.test.template](https://github.com/docsion/rfsh/blob/main/sample/sample.test.template):
 ```
BASE64_RESULT_IN=$(cat) # RESULT FROM SCRIPT RUNS

# DECODE BEFORE USING $echo $BASE64_RESULT_IN | base64 --decode
RESULT_IN=$(echo $BASE64_RESULT_IN | base64 --decode)

# TEST START HERE
if [[ ! "$RESULT_IN" =~ "{{id}}" ]];
then 
	echo "ops!!!" >&2 # print to stderr
	exit 1
fi

echo "good" "{{content}}"
```

Or using built-in function [sample/built-in/item.test.template.sh](https://github.com/docsion/rfsh/blob/main/sample/built-in/item.test.template.sh)
 ```
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
```

### --export-template
If you want to add more column the export .csv (--output) file. Use --export-template options. You receive the input JSON result (via stdin), customize then reply the output as JSON with format: `{"new_column_name": "new_column_value"}`. Please note that, the input result is base64 encoded as default. 

Run the following job script to explore how it works:
 ```
curl https://raw.githubusercontent.com/docsion/rfsh/main/sample/30969f5a-6369-11ee-a32e-f297ad799bdb.sh | sh
#
# |- generated by:
# |- $runflow --generate-job basic -i sample/sample.csv -t sample/sample.template --test-template sample/sample.test.template --export-template sample/sample.export.template
```

You can find sample test at [sample/sample.export.template](https://github.com/docsion/rfsh/blob/main/sample/sample.export.template):
 ```
BASE64_RESULT_IN=$(cat) # RESULT FROM SCRIPT RUNS

# DECODE BEFORE USING $echo ${BASE64_RESULT_IN} | base64 --decode

# CUSTOM EXPORT START HERE
value="ohhh!"

# THEN OUTPUT JSON
echo '{"new_custom_column_name": "'$value'"}'
```

### --built-in
RFSH support built-in functions to help you easier on writing template, test template. You can find the latest built-in functions at [script/built_in.sh](https://github.com/docsion/rfsh/blob/main/script/built_in.sh). And, check it out [sample/built-in](https://github.com/docsion/rfsh/tree/main/sample/built-in) to understand how easy it is.

### --auth-phrase
> Provide an auth phrase to automatically authenticate the running flow as your *supercharge*

You can find the --auth-phrase [here](auth_phrase.txt) for the period running flows (phrase will be expired in 3 months - You can renew it anytime, free & forever). Or Buy me a coffee ($1) with [ a Lifetime --auth-phrase](https://docsion.com/product/rfsh) (END SOON!!! 🏄‍♀️ 481/500 remains, thanks to 19 supporters 🙏).

## Github
You can import an input or a template file from Github repository. Note that if you use private repository, please set `GITHUB_TOKEN` environment variable before running $runflow command. For example:
 ```
GITHUB_TOKEN=<token> runflow basic -i https://github.com/my/privaterepo/blob/main/sample/sample.csv -t https://github.com/docsion/rfsh/blob/main/sample/sample.template
```

You can find Github guideline [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic) to generate new token.

## Telegram
You can send reports to Telegram with Telegram bots, check Telegram guidline [here](https://core.telegram.org/bots). Please note that, the channel must be in public.

## Support
- Beast. D <beast@docsion.com>
