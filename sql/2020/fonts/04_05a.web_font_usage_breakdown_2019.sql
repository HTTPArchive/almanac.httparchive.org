#standardSQL
#web_font_usage_breakdown_2019
SELECT
  client,
  NET.HOST(url) AS host,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct
FROM
    `httparchive.almanac.requests`
WHERE
    date = '2019-07-01' AND
    type = 'font' AND
    NET.HOST(page) != NET.HOST(url)
GROUP BY
    client, url, page
HAVING
  pages >= 1000
ORDER BY
  pct DESC
