SELECT
  percentile,
  client,
  APPROX_QUANTILES(CAST(JSON_QUERY(lighthouse, '$.audits.total-blocking-time.numericValue') AS FLOAT64), 1000)[OFFSET(percentile * 10)] AS tbt
FROM
  `httparchive.all.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2023-10-01' AND
  is_root_page
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
