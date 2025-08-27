#standardSQL
# A11Y technology usage

WITH a11y_technologies AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS freq
  FROM
    `httparchive.technologies.2025_07_01_*`
  WHERE
    category = 'Accessibility'
  GROUP BY
    client
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2025_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  freq,
  total,
  (freq / total) * 100 AS pct
FROM
  a11y_technologies
JOIN
  pages
USING (client)
