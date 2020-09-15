#standardSQL
# 06_01: counts the local and hosted fonts
SELECT
  client,
  COUNTIF(NET.HOST(page) != NET.HOST(url)) AS hosted,
  COUNTIF(NET.HOST(page) = NET.HOST(url)) AS local,
  COUNT(0) AS total,
  ROUND(COUNTIF(NET.HOST(page) != NET.HOST(url)) * 100 / COUNT(0), 2) AS pct_hosted,
  ROUND(COUNTIF(NET.HOST(page) = NET.HOST(url)) * 100 / COUNT(0), 2) AS pct_local
FROM
  `httparchive.almanac.requests`
WHERE
  type = 'font'
GROUP BY
  client