#standardSQL
# 15_04: Compression by Content type
SELECT
  _TABLE_SUFFIX AS client,
  mimeType,
  COUNT(0) AS num_requests,
  SUM(IF(resp_content_encoding = 'gzip', 1, 0)) AS gzip,
  SUM(IF(resp_content_encoding = 'br', 1, 0)) AS brotli,
  SUM(IF(resp_content_encoding = 'deflate', 1, 0)) AS deflate,
  SUM(IF(resp_content_encoding IN ('gzip', 'deflate', 'br'), 0, 1)) AS no_text_compression,
  ROUND(SUM(IF(resp_content_encoding IN ('gzip', 'deflate', 'br'), 1, 0)) / COUNT(0), 2) AS pct_compressed,
  ROUND(SUM(IF(resp_content_encoding = 'br', 1, 0)) / COUNT(0), 2) AS pct_compressed_brotli
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  mimeType
HAVING
  num_requests > 1000
ORDER BY
  num_requests DESC
