#!/bin/sh
duckdb -csv -c "$(< 3_duckdb.sql)"
