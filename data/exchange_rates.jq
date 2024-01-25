.base as $base
| .rates
| to_entries[]
| {
    provider: $provider,
    base: $base,
    quote: .key,
    mid: .value
  }
