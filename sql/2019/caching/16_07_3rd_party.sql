#standardSQL
# 16_07_3rd_party: Set-Cookie on cacheable responses by party
SELECT
  client,
  party,
  type,
  uses_cookies,
  SUM(COUNT(0)) OVER (PARTITION BY client, party) AS all_requests,
  SUM(COUNT(DISTINCT pageid)) OVER (PARTITION BY client, party) AS all_pages,

  SUM(COUNT(0)) OVER (PARTITION BY client, type, party) AS total_of_type,
  COUNT(0) AS total,
  COUNT(DISTINCT pageid) AS pages_using_cookies,

  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client, type, party), 2) AS pct_of_type,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client, party), 2) AS pct_of_all_requests,
  ROUND(COUNT(DISTINCT pageid) * 100 / SUM(COUNT(DISTINCT pageid)) OVER (PARTITION BY client, party), 2) AS pct_of_all_pages
FROM (
  SELECT
    client,
    pageid,
    requestid,
    type,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party
  FROM
    `httparchive.almanac.summary_requests`
)
JOIN (SELECT requestid, reqCookieLen > 0 AS uses_cookies FROM `httparchive.almanac.summary_requests` WHERE date = '2019-07-01')
USING (requestid)
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  type,
  uses_cookies,
  party
ORDER BY
  uses_cookies DESC,
  pct_of_all_pages DESC,
  client,
  party
