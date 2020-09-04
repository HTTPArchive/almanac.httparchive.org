#standardSQL
# 08_04: Most common html lang attributes
SELECT
  client,
  LOWER(JSON_EXTRACT(payload, "$._almanac.html_node.lang")) AS lang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_of_pages
FROM
  `httparchive.pages.2020_08_01_*`
GROUP BY
  client,
  lang
ORDER BY
  pct DESC
