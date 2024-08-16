#standardSQL
# Percent of pages using webpack

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_pages
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    client
),

webpack AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS webpack_pages
  FROM
    `httparchive.technologies.2024_06_01_*`
  WHERE
    lower(app) = 'webpack'
  GROUP BY
    client
)

SELECT
  client,
  webpack_pages,
  total_pages,
  webpack_pages / total_pages AS pct_webpack_pages
FROM
  totals
JOIN
  webpack
USING (client)
ORDER BY
  client
