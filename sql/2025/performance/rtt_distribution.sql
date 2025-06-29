SELECT
  client,
  percentile,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary.crux.metrics.round_trip_time.percentiles.p75) AS FLOAT64), 1000)[OFFSET(percentile * 10)] AS rtt_p75
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-06-01' AND
  is_root_page
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
