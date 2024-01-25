---
title: ClickHouse
---

# ClickHouse

[Official Documentation](https://clickhouse.com/docs/en/intro)

## Installation

```bash
curl https://clickhouse.com/ | sh
```

## Running Queries

### Open Local Shell

```sql
./clickhouse local
ClickHouse local version 24.1.1.1017 (official build).

c02g90ftml85.local :) select tx_id, item_price from file('./data/sales.csv') where tx_id = 'YMEVOKU194' settings format_csv_delimiter='|';

SELECT
    tx_id,
    item_price
FROM file('./data/sales.csv')
WHERE tx_id = 'YMEVOKU194'
SETTINGS format_csv_delimiter = '|'

Query id: 214b4d6f-bfde-4fff-98da-d9d9ace6d9f6

┌─tx_id──────┬─item_price─┐
│ YMEVOKU194 │      28.85 │
│ YMEVOKU194 │       4.12 │
└────────────┴────────────┘

2 rows in set. Elapsed: 0.032 sec.
```

### Run Query and Exit

```bash
./clickhouse local -q "SELECT * FROM file('data/sales.csv') settings format_csv_delimiter='|'"
```

### Start server and connect to it

```bash
./clickhouse server
```

And in another window connect to it

```bash
./clickhouse connect
```

## Reading and writing in different formats

Read CSV and output in Parquet:

```bash
./clickhouse local -q "SELECT * FROM file('data/sales.csv', CSVWithNames) INTO OUTFILE 'data/sales.parquet' FORMAT Parquet" \
  --format_csv_delimiter='|' \
  --output_format_parquet_compression_method=gzip
```

And then read that Parquet file and ouput json lines:

```bash
./clickhouse local -q "select * from file('data/sales.parquet') format JSONEachRow"
```

That would print a json object for each row in the table.

## Import data into a table

Assuming you have a server running.

When ClickHouse server is running, data can only be read from `user_files` folder. First step would be to copy csv files to it:

```bash
cp ./data/sales.csv ./user_files/
```

Create an script named `import_data.sql` that will create the table and import data to it:

```sql
DROP TABLE IF EXISTS compras;

CREATE TABLE IF NOT EXISTS compras (
  tx_id FixedString(10) NOT NULL,
  tx_time DateTime NOT NULL,
  buyer String NOT NULL,
  currency_code FixedString(3) NOT NULL,
  payment_type String NOT NULL,
  credit_card_number String NOT NULL,
  country FixedString(2) NOT NULL,
  department String NOT NULL,
  product String NOT NULL,
  item_price Float64 NOT NULL,
  coupon_code FixedString(4) NULL,
  was_returned String NULL
)
ENGINE = MergeTree
ORDER BY tx_time;

SET format_csv_delimiter = '|';
SET date_time_input_format = 'best_effort';

INSERT INTO compras SELECT * FROM file('sales.csv', CSVWithNames);
```

And then you can run the file to do the import:

```bash
./clickhouse client --queries-file import_data.sql
```

Afterwards, the data can be queried from `compras` table:

```bash
./clickhouse client -q "select currency_code, sum(item_price) from compras group by currency_code"
```

## Additional information

- [Extracting, Converting, and Querying Data in Local Files using clickhouse-local](https://clickhouse.com/blog/extracting-converting-querying-local-files-with-sql-clickhouse-local)
- [Formats for Input and Output Data](https://clickhouse.com/docs/en/interfaces/formats)
