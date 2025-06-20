SELECT
  percentile,
  client,
  is_root_page,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse, '$.audits.unused-javascript.details.overallSavingsBytes') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS unused_js_kbytes
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-06-01'
GROUP BY
  percentile,
  client,
  is_root_page
ORDER BY
  client,
  is_root_page,
  percentile
