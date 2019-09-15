#standardSQL
# 17_02c: Percentage of the sites which use a CDN for secondary domain
SELECT
  client,
  COUNTIF(cdncount > 0) AS freq,
  COUNT(0) AS total,
  ROUND((COUNTIF(cdncount > 0) * 100 / COUNT(0)), 2) AS pct
FROM (
  SELECT
    client,
    COUNTIF(
      _cdn_provider != '' AND
      NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AND
      NET.HOST(url) != NET.HOST(page)
    ) AS cdncount
  FROM
    `httparchive.almanac.requests`
  GROUP BY
    client,
    page)
GROUP BY
  client