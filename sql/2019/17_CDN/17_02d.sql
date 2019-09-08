#standardSQL
# 17_02d: Percentage of the sites which use a CDN for 3P content
SELECT
  client,
  COUNTIF(cdncount > 0) AS freq,
  COUNT(0) AS total,
  ROUND((COUNTIF(cdncount > 0) * 100 / COUNT(0)), 2) AS pct
FROM (
  SELECT
    client,
    COUNTIF(_cdn_provider != '' AND NET.HOST(url) != NET.HOST(page)) AS cdncount
  FROM
    `httparchive.almanac.requests`
  GROUP BY
    client,
    page)
GROUP BY
  client