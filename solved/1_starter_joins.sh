#!/bin/bash
set -eou pipefail

join -t, -1 7 -2 1 -o "1.1 1.10 1.7 2.2" \
  <(tail -n +2 ../data/sales.csv | awk 'BEGIN {FS="|"; OFS=","} {$1=$1; print}' | sort -t, -k 7) \
  <(tail -n +2 ../data/countries.csv | sort -t, -k1,1) \
  | sort -t, -k2n \
  | sed '3q;d'
