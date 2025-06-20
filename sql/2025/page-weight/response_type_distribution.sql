SELECT
  client,
  percentile,
  CAST(JSON_VALUE(summary, '$.type') AS STRING) AS type,
  is_root_page,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.respSize') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  `httparchive.crawl.requests`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'  -- Adjust this date as needed
GROUP BY
  client,
  percentile,
  type,
  is_root_page
ORDER BY
  client,
  type,
  is_root_page,
  percentile
