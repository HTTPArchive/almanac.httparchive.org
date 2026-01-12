SELECT
  client,
  percentile,
  APPROX_QUANTILES(JSON_QUERY(payload, '$._CrUX.metrics.round_trip_time.percentiles.p75'), 1000)[OFFSET(percentile * 10)] AS rtt_p75
FROM
  `httparchive.all.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2024-08-01' AND -- noqa: CV09
  is_root_page
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
