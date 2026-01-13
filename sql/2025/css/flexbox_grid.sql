#standardSQL
# flexbox and grid adoption
WITH totals AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT root_page) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date IN ('2025-07-01', '2024-06-01', '2023-07-01', '2022-06-01', '2021-07-01', '2020-08-01', '2019-07-01')
  GROUP BY
    date,
    client
)

SELECT
  SUBSTR(CAST(date AS STRING), 0, 4) AS year,
  client,
  IF(feat.feature = 'CSSFlexibleBox', 'flexbox', 'grid') AS layout,
  COUNT(DISTINCT root_page) AS freq,
  total,
  COUNT(DISTINCT root_page) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST (features) AS feat
JOIN
  totals
USING (date, client)
WHERE
  date IN ('2025-07-01', '2024-06-01', '2023-07-01', '2022-06-01', '2021-07-01', '2020-08-01', '2019-07-01') AND
  feature IN ('CSSFlexibleBox', 'CSSGridLayout')
GROUP BY
  year,
  client,
  layout,
  total
ORDER BY
  year DESC,
  pct DESC
