---
title: The Data Kitchen
classic: true
---

# The Data Kitchen

Welcome to our restaurant! This site was designed as an experiment to help people understand how to use simple tools to process data locally.

## 🥦 Appetizers: The Unix Salad

[Recipes](./starters.html)

The file `sales.csv` contains a list of purchase receipts with all the articles they contain. Each purchase is identified by the field `tx_id` and each article bought has a price `item_price` and a two-letter code identifying the `country`.

In this recipe, you are required to produce a list with the receipts, but adding the full country name at the end. The translation between country codes and labels can be found in `countries.csv`.

Result should look like:

```csv
SBXWHCG156,1.99,MV,Maldives
BEIGKQD194,93.87,MV,Maldives
BYXCGLP161,4.44,MW,Malawi
```

Solve the exercise by sending the ante-penultimate row, sorted by `item_price` descending.

```bash
curl -sX POST kitchen.luisbelloch.es/api/:team/e1 -d 'FPQINMY120,0.04,SD,Sudan'
```

## Entrées - A tale of two choices

#### 🌶️ Option A: An AWKward chili soup

[Awkward Recipes](./starters.html#awk)

Using `awk`, read the file `sales.csv` and produce a list of the top-ten countries with most sales. Sorting is not a good operation for `awk`, you may want to use the `sort` command.

Solve the exercise by sending the second row

```bash
curl -sX POST kitchen.luisbelloch.es/api/:team/e2a -d 'KM|595.81'
```

#### 🍗 Option B: Pandas Fillet

[How to prepare a Panda for cooking](./starters.html#pandas)

Using Pandas, produce a list of the top-ten countries with more sales.

One easy way to get started is to use a [Jupyter environment](https://jupyter-docker-stacks.readthedocs.io/en/latest/) in Docker:

```bash
docker run -v $(pwd):/home/jovyan/ -p 8888:8888 -p 4040:4040 jupyter/scipy-notebook
```

Then navigate to the provider URL. `ctrl+enter` executes the current cell, use `a` or `b` keys to add cells. Alternatively you may use [VS Code Jupyter extensions](https://code.visualstudio.com/docs/datascience/jupyter-notebooks), but it's a bit painful to install.

Solve the exercise by sending the second row

```bash
curl -sX POST kitchen.luisbelloch.es/api/:team/e2b -d 'KM|595.81'
```

## 🦆 Main: Slow-roasted DuckDB

[Roast Duck Recipes](./duckdb.html)

The file `pancake_orders.10M.csv.gz` contains 10 million registers, with the following columns:

```sql
┌──────────────┬────────┬────────────┬────────────────┬─────────────┐
│      ts      │ price  │ item_count │ source_country │ coupon_code │
│   timestamp  │ double │   int64    │    varchar     │   varchar   │
├──────────────┼────────┼────────────┼────────────────┼─────────────┤
│ 16:36:19.794 │   3.85 │          1 │ BR             │ 501826      │
│ 16:49:30.072 │   6.36 │          4 │ PY             │ 2bd108      │
│ 16:51:26.371 │   6.36 │          1 │ MF             │ cfaed6      │
└──────────────┴────────┴────────────┴────────────────┴─────────────┘
```

Data file can be found here: [pancake_orders.10M.csv.gz](https://storage.googleapis.com/data.luisbelloch.es/pancake_orders.10M.csv.gz). Do not decompress it, DuckDB is able to read compressed files on the fly.

You are required to get the top-ten countries with more sales, mixing the data with `countries.jsonl` file. You can only use DuckDB, no external tooling.

Result should look like this:

```csv
country,total
Guinea-Bissau,297833.1000000053
"Cocos (Keeling) Islands",298836.7600000056
Namibia,299101.0800000052
...
```

Solve the exercise by sending the 4<sup>th</sup> row (Finland).

```bash
curl -sX POST kitchen.luisbelloch.es/api/:team/e3 -d 'Namibia,299101.0800000052'
```

**Optional**: Try to query directly the CSV and also load the data into a `some.duckdb` file. Does the later make a difference in performance?

**Optional**: Save the results [as Parquet](https://duckdb.org/docs/guides/import/parquet_import) and repeat the performance experiment.

## 🍣 Main: Marinated ClickHouse

[Russian Recipes](./clickhouse.html)

Repeat the DuckDB exercise, but this time using ClickHouse:

1. Run query using `clickhouse local`
2. Start server and create two tables: `orders` and `countries`
3. Load the data on them. You may benefit by using Parquet format from previous exercise. Also remember that ClickHouse is able to read compressed files on the fly.
4. Run query using `clickhouse client`

Solve the exercise by sending the 5<sup>th</sup> row (Peru), like in the previous exercise.

```bash
curl -sX POST kitchen.luisbelloch.es/api/:team/e4 -d 'Namibia,299101.0800000052'
```

## 🧁 Dessert: JQ salty rotten chocolate pudding

[Dessert Recipes](./starters.html#jq)

Using `jq` _only_, read the file `sales.csv` and produce a list the top-ten countries with most sales. Because reasons.

---

**Food Allergy Warning**: _Please be advised that our food may have come in contact or contain unix nuts, terminal traces, bash fish or console peanuts._

🌾 Gluten-Free
