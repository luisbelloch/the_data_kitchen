select C.name as country, R.total from
  (select source_country, sum(price) as total
    from read_csv('../data/pancake_orders.10M.csv.gz', auto_detect=true)
    group by source_country
    order by total
    limit 10
  ) R
  inner join read_json_auto('../data/countries.jsonl') C
  on C.code = R.source_country;
