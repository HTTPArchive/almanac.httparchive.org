SELECT
  percentile,
  client,
  APPROX_QUANTILES(INT64(summary.bytesHtml) / 1014, 1000)[OFFSET(percentile * 10)] AS kb_html
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2025-07-01'
GROUP BY
  percentile,
  client
ORDER BY
  client
