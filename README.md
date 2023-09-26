<a href="https://github.com/docsion/rfsh">
  <img alt="RFSH – a Free-forever flows running tool." src="https://github.com/docsion/rfsh/blob/main/static/rfsh_banner_v2.png?raw=true">
  <h1 align="center">RFSH</h1>
</a>

<p align="center">
  A Free-forever flows running tool. 💥
</p>

> a.k.a @RUNFLOW_SH

## Install
```
curl https://raw.githubusercontent.com/docsion/rfsh/main/i.sh | sh
```

## Run

### help
```
$ ./runflow help
runflow - Running your flows made fast, safe, easy.
Usage: runflow [options...] command [options...]

Commands:
   basic    Execute a basic flow
   version  Show the version

Options:
   --generate-job       Generate an all-in-one job file which contains input data, template script, command flags that can run anywhere.
   --auth-phrase value  Provide an auth phrase to automatically authenticate the running flow as your *supercharge*

Author:
   Beast. D <beast@docsion.com>

Copyright:
   (c) 2023 Docsion Team.
```

### basic
```
$ ./runflow basic
runflow basic - Execute a basic flow
Usage: runflow basic [options...]

Description:
   Concurrently run a template with values from a CSV file.
   Example: $runflow basic -i sample.csv -t sample.template -o sample.out.csv
   More info: https://github.com/docsion/rfsh/tree/main/sample

Options:
   --input value, -i value          CSV file with values in comma-separated format. Headers define variable names (e.g., id,content<new line>1,hey @RUNFLOW_SH here!).
   --template value, -t value       Location of the Bash script template. Variables are in the format {{variable_name}} (e.g., echo {{id}} {{content}}).
   --output value, -o value         Output file location
   --concurrent value               Number of concurrent workers (default: 4)
   --retries value                  Number of retries on failure (default: 0)
   --dry-run                        Only print the script to --output that would be execute, without executing it.
   --report-remote-stream value     *supercharge* Send reports to remote stream. Support: telegram
   --report-telegram-token value    Telegram Bot Token. More info: https://core.telegram.org/bots
   --report-telegram-channel value  Telegram Channel.
```

### --auth-phrase
> Provide an auth phrase to automatically authenticate the running flow as your *supercharge*

You can use [free --auth-phrase](auth_phrase.txt) for the period running flows (phrase will be expired in 3 months). Or Buy me a coffee ($1) with [ a Lifetime --auth-phrase](https://docsion.com/product/rfsh) (481/500 remains, thanks to 19 supporters 🙏)

## Support
- Beast. D <beast@docsion.com>
