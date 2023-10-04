<a href="https://github.com/docsion/rfsh">
  <img alt="RFSH – a Free-forever flows running tool." src="https://github.com/docsion/rfsh/blob/main/static/rfsh_banner_v2.png?raw=true">
  <h1 align="center">RFSH</h1>
</a>

<p align="center">
  Supercharge your shell scripts - Running shell scripts in batch, concurrently, fully customized with variable .
</p>

> a.k.a @RUNFLOW_SH

## What is it?
At the first point of view, I want to create a tool which can help our team run the bash script easier, faster, safer, with clearly reports, so I build RFSH.

To me, the first ability of good software is privacy matter. I want to create a good software and I don't want to make rich by charging on things running on your own resources (your computer, your server, your cloud,...). So basically, RFSH will be free-forever for usage.

You put a .csv file, a bash script as a template file, RFSH will take care the rest, then you will receive the clearly reports after all. Things happen on your machine, safe and sound.

For **supercharge** features, you must include the [--auth-phrase](#--auth-phrase). You can renew it anytime, free & forever.

## Features
1. Concurrently run a template with values from a CSV file [link](#basic).
2. Generate an all-in-one job file which contains input data, template script, command flags that can run anywhere [link](#help).
3. Send reports to remotely stream. Support: telegram (**supercharge**) [link](#basic).

## Sample
Run the following script to execute the basic sample. You can find the script, input data, template at [sample](https://github.com/docsion/rfsh/tree/main/sample):
 ```
curl https://raw.githubusercontent.com/docsion/rfsh/main/sample/be918dae-6113-11ee-815c-f297ad799bdb.sh | sh
#
# |- generated by:
# |- $runflow --generate-job basic -t sample/sample.template -i sample/sample.csv -o sample.out.csv --retries 2
```

Console output:
 ```
[RFSH] 2023/10/02 - 18:09:46 |       RUN  |     88µs |    0% |       0 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |     90µs |    0% |       0 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |     90µs |    0% |       0 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |     89µs |    0% |       0 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      3ms |   12% |       1 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |      3ms |   12% |       1 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |      4ms |   25% |       2 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      4ms |   25% |       2 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      4ms |   38% |       3 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |      4ms |   50% |       4 ✓  |       0 𐄂  |      4 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      4ms |   50% |       4 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |       RUN  |      4ms |   50% |       4 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      6ms |   62% |       5 ✓  |       0 𐄂  |      3 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      7ms |   75% |       6 ✓  |       0 𐄂  |      2 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      7ms |   88% |       7 ✓  |       0 𐄂  |      1 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |      GOOD  |      7ms |  100% |       8 ✓  |       0 𐄂  |      0 ‣ |      0 ↩︎ | sample.out.csv

[RFSH] 2023/10/02 - 18:09:46 |    REPORT  |      7ms |  100% |       8 ✓  |       0 𐄂  |      0 ‣ |      0 ↩︎ | sample.out.csv
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
runflow basic - Execute a basic flow .
Usage: runflow basic [options...]

Description:
   Concurrently run a template with values from a CSV file .
   Example: $runflow basic -i sample.csv -t sample.template
   More info: https://github.com/docsion/rfsh/tree/main/sample

Options:
   --input value, -i value          CSV file with values in comma-separated format. Headers define variable names (e.g., id,content<new line>1,hey @RUNFLOW_SH here!). Support: file, url (http/https) .
   --template value, -t value       Location of the Bash script template. Variables are in the format {{variable_name}} (e.g., echo {{id}} {{content}}). Support: file, url (http/https) .
   --output value, -o value         Output file location .
   --concurrent value               Number of concurrent workers . (default: 4)
   --retries value                  Number of retries on failure . (default: 0)
   --dry-run                        Only print the script to --output that would execute, without executing it .
   --report-remote-stream value     *supercharge* Send reports to remotely stream. Support: telegram .
   --report-telegram-token value    Telegram Bot Token. More info: https://core.telegram.org/bots .
   --report-telegram-channel value  Telegram channel .
```

### --auth-phrase
> Provide an auth phrase to automatically authenticate the running flow as your *supercharge*

You can find the --auth-phrase [here](auth_phrase.txt) for the period running flows (phrase will be expired in 3 months). Or Buy me a coffee ($1) with [ a Lifetime --auth-phrase](https://docsion.com/product/rfsh) (481/500 remains, thanks to 19 supporters 🙏)

## Support
- Beast. D <beast@docsion.com>
