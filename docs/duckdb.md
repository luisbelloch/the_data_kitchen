---
title: DuckDB
---

# DuckDB

[Official Guides](https://duckdb.org/docs/guides/index)

## Installation

It comes as a single binary, we just have to download and unpack:

```bash
wget https://github.com/duckdb/duckdb/releases/download/v0.9.2/duckdb_cli-linux-amd64.zip
unzip duckdb_cli-linux-amd64.zip
```

## Running Queries

### Open Shell

```sql
./duckdb
D select tx_id, item_price from read_csv('./data/sales.csv', AUTO_DETECT=TRUE) where tx_id = 'YMEVOKU194';
┌────────────┬────────────┐
│   tx_id    │ item_price │
│  varchar   │   double   │
├────────────┼────────────┤
│ YMEVOKU194 │      28.85 │
│ YMEVOKU194 │       4.12 │
└────────────┴────────────┘
```

### Run Query and Exit

```bash
./duckdb -c "select * from read_csv('data/sales.csv', AUTO_DETECT=TRUE)"
```

## Creating a database

Just append the filename when running `duckdb`. For instance, this will create a table named `purchases` in a file at `data/sales.duckdb`:

```bash
duckdb data/sales.duckdb -c "CREATE TABLE purchases AS SELECT * FROM read_csv('data/sales.csv', header=true, auto_detect=true)"
```

After that, you can open the file and query the `purchases` table:

```bash
./duckdb data/sales.duckdb
v0.9.2 3c695d7ba9
Enter ".help" for usage hints.
D describe purchases;
┌────────────────────┬─────────────┬─────────┬─────────┬─────────┬───────┐
│    column_name     │ column_type │  null   │   key   │ default │ extra │
│      varchar       │   varchar   │ varchar │ varchar │ varchar │ int32 │
├────────────────────┼─────────────┼─────────┼─────────┼─────────┼───────┤
│ tx_id              │ VARCHAR     │ YES     │         │         │       │
│ tx_time            │ TIMESTAMP   │ YES     │         │         │       │
│ buyer              │ VARCHAR     │ YES     │         │         │       │
│ currency_code      │ VARCHAR     │ YES     │         │         │       │
│ payment_type       │ VARCHAR     │ YES     │         │         │       │
│ credit_card_number │ VARCHAR     │ YES     │         │         │       │
│ country            │ VARCHAR     │ YES     │         │         │       │
│ department         │ VARCHAR     │ YES     │         │         │       │
│ product            │ VARCHAR     │ YES     │         │         │       │
│ item_price         │ DOUBLE      │ YES     │         │         │       │
│ coupon_code        │ VARCHAR     │ YES     │         │         │       │
│ was_returned       │ VARCHAR     │ YES     │         │         │       │
├────────────────────┴─────────────┴─────────┴─────────┴─────────┴───────┤
│ 12 rows                                                      6 columns │
└────────────────────────────────────────────────────────────────────────┘
D .mode line
D select count(*) as con_descuento from purchases where coupon_code is not null;
con_descuento = 414
```

## Change output format

Use the `.mode csv`, also `-csv` or `-json` command line options. You can check the [available output formats in the documentation](https://duckdb.org/docs/api/cli/output-formats).

```sql
D .mode csv
D select tx_id, item_price from read_csv('./data/sales.csv', AUTO_DETECT=TRUE) where tx_id = 'YMEVOKU194';
tx_id,item_price
YMEVOKU194,28.85
YMEVOKU194,4.12
```

Remember you can always save the data to a different file:

```bash
./duckdb -jsonlines -c "select tx_id, item_price from read_csv('./data/sales.csv', AUTO_DETECT=TRUE) where tx_id = 'YMEVOKU194';" > ./data/sales.jsonl
```

Use `>>` instead of `>` to append to the file.

## Converting between CSV and Parquet

For instance, using `sales.csv`:

```bash
./duckdb -c "copy (select * from read_csv('data/sales.csv', AUTO_DETECT=TRUE)) to 'data/sales.parquet' (format 'parquet')"
```
