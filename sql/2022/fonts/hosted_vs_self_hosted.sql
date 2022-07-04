#standardSQL #self_hosted_vs_hosted
SELECT
  client,
  CASE
    WHEN pct_self_hosted_hosted = 1 THEN 'self-hosted'
    WHEN pct_self_hosted_hosted = 0 THEN 'external'
    ELSE 'both'
  END AS font_host,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(NET.HOST(page) = NET.HOST(url)) / COUNT(0) AS pct_self_hosted_hosted
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.pages.2022_06_01_*`)
USING
  (client, page)
GROUP BY
  client,
  font_host
ORDER BY
  font_host,
  client
