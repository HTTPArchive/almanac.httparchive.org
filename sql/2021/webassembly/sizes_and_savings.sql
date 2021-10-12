SELECT
  percentile,
  client,
  APPROX_QUANTILES(raw_size, 1000)[OFFSET(percentile * 10)] AS raw_size,
  APPROX_QUANTILES(size.total, 1000)[OFFSET(percentile * 10)] AS size_total,
  APPROX_QUANTILES(size.total_opt, 1000)[OFFSET(percentile * 10)] AS size_total_opt,
  APPROX_QUANTILES(size.total_opt_br, 1000)[OFFSET(percentile * 10)] AS size_total_opt_br,
  APPROX_QUANTILES(opt_savings, 1000)[OFFSET(percentile * 10)] AS opt_savings,
  APPROX_QUANTILES(br_savings, 1000)[OFFSET(percentile * 10)] AS br_savings,
  APPROX_QUANTILES(raw_savings, 1000)[OFFSET(percentile * 10)] AS raw_savings
FROM
  (
    SELECT
      *,
      size.total - size.total_opt AS opt_savings,
      raw_size - size.total_br AS br_savings,
      raw_size - size.total_opt_br AS raw_savings
    FROM
      `httparchive.almanac.wasm_stats`
    WHERE
      date = '2021-09-01'
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
