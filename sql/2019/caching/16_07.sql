#standardSQL
# 16_07: Set-Cookie on cacheable responses
SELECT
  client,
  uses_cookies,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS all_requests,
  SUM(COUNT(DISTINCT pageid)) OVER (PARTITION BY client) AS all_pages,

  type,
  SUM(COUNT(0)) OVER (PARTITION BY client, type) AS total_of_type,
  COUNT(0) AS total,
  COUNT(DISTINCT pageid) AS pages_using_cookies,

  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client, type), 2) AS pct_of_type,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_of_all_requests,
  ROUND(COUNT(DISTINCT pageid) * 100 / SUM(COUNT(DISTINCT pageid)) OVER (PARTITION BY client), 2) AS pct_of_all_pages
FROM
  `httparchive.almanac.summary_requests`
JOIN (SELECT requestid, reqCookieLen > 0 AS uses_cookies FROM `httparchive.almanac.summary_requests` WHERE date = '2019-07-01')
USING (requestid)
WHERE
  date = '2019-07-01'
GROUP BY
  client, type, uses_cookies
ORDER BY
  uses_cookies DESC, pct_of_all_pages DESC
