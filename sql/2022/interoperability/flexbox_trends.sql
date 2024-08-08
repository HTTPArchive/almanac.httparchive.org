#standardSQL
# CSS flexbox adoption

WITH totals AS (
  SELECT
    CAST('2022-06-01' AS DATE) AS yyyymmdd,
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
  UNION ALL
  SELECT
    CAST('2021-07-01' AS DATE) AS yyyymmdd,
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
  UNION ALL
  SELECT
    CAST('2020-08-01' AS DATE) AS yyyymmdd,
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client
  UNION ALL
  SELECT
    CAST('2019-07-01' AS DATE) AS yyyymmdd,
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    client
)

SELECT
  SUBSTR(CAST(yyyymmdd AS STRING), 0, 4) AS year,
  client,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.blink_features.features`
JOIN
  totals
USING (yyyymmdd, client)
WHERE
  yyyymmdd IN ('2022-06-01', '2021-07-01', '2020-08-01', '2019-07-01') AND
  feature IN ('CSSFlexibleBox')
GROUP BY
  year,
  client,
  total
ORDER BY
  year DESC,
  pct DESC
