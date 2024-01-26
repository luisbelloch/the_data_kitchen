#!/bin/sh
./clickhouse local \
  --format=JSON \
  --queries-file 4_clickhouse.sql \
  --format_csv_delimiter=',' | jq
