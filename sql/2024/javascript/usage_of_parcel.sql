#standardSQL
# Percent of pages using parcel

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_pages
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    client
),

parcel AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS parcel_pages
  FROM
    `httparchive.technologies.2024_06_01_*`
  WHERE
    app = 'parcel'
  GROUP BY
    client
)

SELECT
  client,
  parcel_pages,
  total_pages,
  parcel_pages / total_pages AS pct_parcel_pages
FROM
  totals
JOIN
  parcel
USING (client)
ORDER BY
  client
