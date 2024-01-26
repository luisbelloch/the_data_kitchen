---
title: Starters
---

# Starter Recipes

## Basics

### Select first N or last M lines

```bash
head -n 10 data/sales.csv
tail -n 10 data/sales.csv
```

### Select columns 1 and 7 from a CSV

```bash
cut -d"|" -f 1,7 data/sales.csv
```

### Remove first line

```bash
tail -n +2 data/sales.csv
```

### Sort CSV by 3<sup>rd</sup> field

```bash
sort -t, -k 3
```

### Sort second column numerically

```bash
sort -k2 -n -r
```

- `-n` tells sed to sort numerically
- `-h` sorts numerically assuming SI qualifiers, like 4K, 2M etc
- `-r` produces a descending order

### Join two files by columns 1 and 3

Assuming both files are sorted by those columns.

```bash
join -1 1 -2 3 a.csv b.csv
```

### Remove specific characters

Many ways to do it, easiest is to use [tr](https://man.freebsd.org/cgi/man.cgi?tr).

```bash
> echo hello | tr -d 'l'
heo
```

## AWK

From the manual: [Unix tools re-implemented in simple AWK scripts](https://www.gnu.org/software/gawk/manual/gawk.html#Clones)

### Print Specific Fields

Script can be run inline, or also in a separated file: `awk -f print_fields.awk file.txt`

```awk
{print $1, $3}
```

### Sum of a column values

```awk
{sum += $2} END {print sum}
```

### Print Fields from CSV

```awk
BEGIN {
  FS = ","
}
{
  print $1, $3
}
```

### Add new field at the end

```awk
{print $0, $1+$2}
```

### Count line occurrences

```awk
{
  count[$0]++
}

END {
  for (line in count) {
    print line, count[line]
  }
}
```

### Count field occurrences

```awk
{count[$2]++} END {for (val in count) print val, count[val]}
```

### Associative Arrays: Sum Values for Key

```awk
{
  arr[$1] += $2
}

END {
  for (key in arr) {
    print key, arr[key]
  }
}
```

## XSV

[github.com/BurntSushi/xsv](https://github.com/BurntSushi/xsv)

### Select Columns

Remove all columns except first one and 7th.

```bash
xsv select 1,7 filename.csv
```

### Display as table

```bash
xsv select 1,7 filename.csv | xsv table
```

### Change delimiters

Assuming input file has a semi-colon `;`, this command will output regular CSV:

```bash
xsv fmt --delimiter ";" filename.csv
```

This is the equivalent in AWK:

```bash
awk 'BEGIN {FS="|"; OFS=","} {$1=$1; print}'
```

## Pandas

### Setting up a minimal environment

Create a virtual environment, activate it and install Pandas. Using python 3.10, this takes less than 30 seconds:

```bash
python -m venv .wadus
source .wadus/bin/activate
pip install pandas
```

### Where do I get help?

[User Guide](https://pandas.pydata.org/docs/user_guide/index.html) should cover 90% of the cases.

## JQ

### Key-value access

Given this file:

```json
{
  "base": "USD",
  "date": "2016-02-05",
  "rates": {
    "AUD": 1.3911,
    "BGN": 1.7459
  }
}
```

We would like to produce the following `jsonl` file:

```bash
{"base":"usd","quote":"AUD","mid":1.3911}
{"base":"usd","quote":"BGN","mid":1.7459}
```

And the script would be:

```bash
jq -c '.rates | to_entries[] | {base:"usd", quote: .key, mid: .value}' exchange_rates_usd.json
```

### Convert json file to csv

```bash
jq -rcs '.[] | [.code,.name] | @csv' countries.jsonl
```

### Building objects

You can build it like `{ some: .code }` or use the shortcut directly `{code}`:

```bash
jq -rcs '.[] | {code}' countries.jsonl
```

```json
{"code":"YE"}
{"code":"ZM"}
```

Arrays are built using `[]` instead of `{}`, as expected.

### Full-fledged programs in external files

Normally you would run it using `-f` option.

For instance, the `exchange_rates.json` example can be also produced like this:

```json
{"provider":"xe","base":"USD","quote":"AUD","mid":1.3911}
{"provider":"xe","base":"USD","quote":"BGN","mid":1.7459}
```

by using:

```bash
jq -c --arg provider 'xe' -f exchange_rates.jq exchange_rates_usd.json
```

where `exchange_rates.jq` script is:

```jq
.base as $base
| .rates
| to_entries[]
| {
    provider: $provider,
    base: $base,
    quote: .key,
    mid: .value
  }
```

Notice the `base` is fetched from the top level and reused afterwards. The `provider` field is set from the outside with `--arg`.

### Where do I get help?

Reading [the manual](https://jqlang.github.io/jq/manual/) is a good starting point. It's quite long, don't get anxiety and rtfm before googling.

For some inspiration, you may check [a bigger example](https://github.com/flox/flox-bash/blob/main/lib/diff-catalogs.jq)
