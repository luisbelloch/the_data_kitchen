---
author: luis b.
paging: "%d / %d"
---

```
                ████████╗██╗░░██╗███████╗  ██████╗░░█████╗░████████╗░█████╗░
                ╚══██╔══╝██║░░██║██╔════╝  ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
                ░░░██║░░░███████║█████╗░░  ██║░░██║███████║░░░██║░░░███████║
                ░░░██║░░░██╔══██║██╔══╝░░  ██║░░██║██╔══██║░░░██║░░░██╔══██║
                ░░░██║░░░██║░░██║███████╗  ██████╔╝██║░░██║░░░██║░░░██║░░██║
                ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝  ╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝

                    ██╗░░██╗██╗████████╗░█████╗░██╗░░██╗███████╗███╗░░██╗
                    ██║░██╔╝██║╚══██╔══╝██╔══██╗██║░░██║██╔════╝████╗░██║
                    █████═╝░██║░░░██║░░░██║░░╚═╝███████║█████╗░░██╔██╗██║
                    ██╔═██╗░██║░░░██║░░░██║░░██╗██╔══██║██╔══╝░░██║╚████║
                    ██║░╚██╗██║░░░██║░░░╚█████╔╝██║░░██║███████╗██║░╚███║
                    ╚═╝░░╚═╝╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝
```

---

## What's this?

Hands-on talk about **processing data** locally.

---

## What's this?

Hands-on talk about processing data locally.

## Why are we doing this?

It's painful to see people using editors or Google Sheets to manipulate data.

---

# What's in the menu?

- 🥦 Appetizers  The **Unix** Salad
- 🌶️  Entrées     AWK or Pandas
- 🦆 Main        Slow-roasted **DuckDB**
- 🍣 Main        Marinated **ClickHouse**
- 🧁 Dessert     **JQ** salty rotten chocolate pudding

---

# Start! Where's the menu? 👩🏻‍🍳

kitchen.luisbelloch.es

---

# Start!

kitchen.luisbelloch.es

## Where do it get the data files?

github.com/luisbelloch/the_data_kitchen

### Submiting an exercise

```bash
curl -sX POST https://kitchen.luisbelloch.es/api/:team/e1 -d 'FPQINMY120,0.04,SD,Sudan'
```

---

## The Ranking

```bash
curl -s https://kitchen.luisbelloch.es/api/solved | ./jtab
```



