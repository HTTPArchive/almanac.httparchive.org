#standardSQL
# 17_01: Top CDNs used on the root HTML pages
SELECT
  client,
  _cdn_provider AS cdn,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND((COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client)), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE
  firstHtml
GROUP BY
  client,
  cdn
ORDER BY
  freq / total DESC
