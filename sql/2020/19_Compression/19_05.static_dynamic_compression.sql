#standardSQL
#static dynamic compression
SELECT
  client,
  resp_content_encoding,
  IF(REGEXP_CONTAINS(resp_cache_control, r'(?i)immutable'), 'static', 'dynamic') AS cache_control,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
FROM 
  `httparchive.almanac.requests`
WHERE
  date='2020-08-01' AND resp_content_encoding = 'gzip' 
GROUP BY
  client,
  resp_content_encoding,
  resp_cache_control
ORDER BY
  num_requests DESC