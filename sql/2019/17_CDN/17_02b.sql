#standardSQL
# 17_02b: Percentage of the sites which use a CDN for HTML resource
SELECT
  client,
  COUNTIF(cdncount > 0) AS freq,
  COUNT(0) AS total,
  ROUND((COUNTIF(cdncount > 0) * 100 / COUNT(0)), 2) AS pct
FROM (
  SELECT
    client,
    COUNTIF(_cdn_provider != '') AS cdncount
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
  GROUP BY
    client,
    page)
GROUP BY
  client