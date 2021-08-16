#standardSQL
# The top domains to use immutable Cache-Control directive.
SELECT
  _TABLE_SUFFIX AS client,
  NET.HOST(url) AS domain,
  COUNT(DISTINCT pageid) AS pages,
  COUNT(0) AS requests,
  SUM(COUNT(DISTINCT pageid)) OVER (PARTITION BY 0) AS total_pages,
  SUM(COUNT(0)) OVER(PARTITION BY 0) AS total_requests
FROM
  `httparchive.summary_requests.2020_08_01_*`
WHERE
  REGEXP_CONTAINS(resp_cache_control, r'(?i)immutable')
GROUP BY
  client,
  domain
ORDER BY
  client,
  requests DESC
