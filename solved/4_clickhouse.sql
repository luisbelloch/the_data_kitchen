select C.name as country, R.total from
(
  select source_country, sum(price) as total
  from file('../data/pancake_orders.10M.csv.gz', CSVWithNames)
  group by source_country
  order by sum(price)
  limit 10
) R
inner join file('../data/countries.jsonl', JSONEachRow) C
on C.code = R.source_country;
