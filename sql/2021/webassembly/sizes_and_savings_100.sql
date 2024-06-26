SELECT
  percentile,
  client,
  APPROX_QUANTILES(raw_size, 1000)[OFFSET(percentile * 10)] AS raw_size,
  APPROX_QUANTILES(size.total, 1000)[OFFSET(percentile * 10)] AS size_total,
  APPROX_QUANTILES(size.total_br, 1000)[OFFSET(percentile * 10)] AS size_total_br,
  APPROX_QUANTILES(size.total_strip, 1000)[OFFSET(percentile * 10)] AS size_total_strip,
  APPROX_QUANTILES(size.total_strip_br, 1000)[OFFSET(percentile * 10)] AS size_total_strip_br,
  APPROX_QUANTILES(size.total_opt, 1000)[OFFSET(percentile * 10)] AS size_total_opt,
  APPROX_QUANTILES(size.total_opt_br, 1000)[OFFSET(percentile * 10)] AS size_total_opt_br,
  APPROX_QUANTILES((raw_size - size.total_br), 1000)[OFFSET(percentile * 10)] AS br_savings,
  APPROX_QUANTILES((size.total_br - size.total_strip_br), 1000)[OFFSET(percentile * 10)] AS strip_br_savings,
  APPROX_QUANTILES((size.total_strip_br - size.total_opt_br), 1000)[OFFSET(percentile * 10)] AS opt_br_savings,
  APPROX_QUANTILES((size.total_strip - size.total_opt), 1000)[OFFSET(percentile * 10)] AS opt_savings
FROM
  `httparchive.almanac.wasm_stats`,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  date = '2021-09-01'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
