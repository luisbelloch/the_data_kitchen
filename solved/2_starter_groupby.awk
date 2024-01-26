BEGIN {
  FS="|"
  OFS="|"
}
NR > 1 {
  total[$7] += $10
}
END {
  for (c in total) {
    print c, total[c]
  }
}
