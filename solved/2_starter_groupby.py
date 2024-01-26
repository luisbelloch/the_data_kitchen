import pandas as pd
import sys

df = pd.read_csv('../data/sales.csv', delimiter='|')
top10 = df.groupby('country')['item_price'].sum() \
  .reset_index() \
  .sort_values('item_price', ascending=False) \
  .head(10)

top10.to_csv(sys.stdout, index=False)
