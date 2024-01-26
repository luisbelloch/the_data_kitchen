#!/bin/bash

awk -f 2_starter_groupby.awk ../data/sales.csv \
  | sort -t"|" -k2nr \
  | head -n 10
