#standardSQL
# Top WordPress page builder combinations
SELECT
  client,
  page_builders,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    app = 'WordPress'
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    ARRAY_TO_STRING(ARRAY_AGG(app ORDER BY app), ', ') AS page_builders
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Page builders'
  GROUP BY
    client,
    url
)
USING (client, url)
GROUP BY
  client,
  page_builders
ORDER BY
  pct DESC
