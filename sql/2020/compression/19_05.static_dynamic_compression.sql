#standardSQL
#static dynamic compression
SELECT
  client,
  resp_content_encoding,
  IF(LOWER(resp_cache_control) LIKE "%no-store%", 'dynamic', 'static') AS static_or_dynamic,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  resp_content_encoding,
  static_or_dynamic
ORDER BY
  num_requests DESC
