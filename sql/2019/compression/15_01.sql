#standardSQL
  # 15_01: What compression formats are being used (gzip, brotli, etc)
SELECT
  _TABLE_SUFFIX AS client,
  resp_content_encoding,
  COUNT(0) AS num_requests,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  resp_content_encoding
ORDER BY
  num_requests DESC
