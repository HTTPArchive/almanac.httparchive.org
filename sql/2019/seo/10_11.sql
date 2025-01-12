#standardSQL
# 10_11: Linking - fragment URLs (together with SPAs to navigate content)
SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNTIF(navigate_hash) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNTIF(navigate_hash) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].navigateHash") AS INT64) > 0 AS navigate_hash
  FROM
    `httparchive.pages.2019_07_01_*`
)
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX, url)
WHERE
  app IN ('React', 'Angular', 'Vue.js')
GROUP BY
  client,
  app
ORDER BY
  freq / total DESC
