#standardSQL
# The top domains to use immutable Cache-Control directive.
SELECT
  _TABLE_SUFFIX AS client,
  NET.HOST(url) AS host,
  COUNT(DISTINCT pageid) AS pages,
  COUNT(0) AS requests,
  SUM(COUNT(DISTINCT pageid)) OVER () AS total_pages,
  SUM(COUNT(0)) OVER () AS total_requests,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_requests
FROM
  `httparchive.summary_requests.2021_07_01_*`
WHERE
  REGEXP_CONTAINS(resp_cache_control, r'(?i)immutable')
GROUP BY
  client,
  domain
ORDER BY
  client,
  pct_requests DESC
LIMIT 200
