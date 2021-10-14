#standardSQL
# Most common html lang attributes
SELECT
  _TABLE_SUFFIX AS client,
  LOWER(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.html_node.lang')) AS lang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_of_pages
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  _TABLE_SUFFIX,
  lang
HAVING
  freq >= 100
ORDER BY
  pct_of_pages DESC
