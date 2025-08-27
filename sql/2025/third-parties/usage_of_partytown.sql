#standardSQL
# Percent of pages using Partytown

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_pages
  FROM
    `httparchive.summary_pages.2025_07_01_*`
  GROUP BY
    client
),

partytown AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS partytown_pages
  FROM
    `httparchive.technologies.2025_07_01_*`
  WHERE
    app = 'Partytown'
  GROUP BY
    client
)

SELECT
  client,
  partytown_pages,
  total_pages,
  partytown_pages / total_pages AS pct_partytown_pages
FROM
  totals
JOIN
  partytown
USING (client)
ORDER BY
  client
