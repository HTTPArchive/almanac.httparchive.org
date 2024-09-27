-- Section: Development
-- Question: How prevalent is OpenType support?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    REGEXP_CONTAINS(
      JSON_EXTRACT(payload, '$._font_details.table_sizes'),
      '(?i)GPOS|GSUB'
    ) AS support
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    is_root_page AND
    type = 'font'
  GROUP BY
    date,
    client,
    url,
    support
)

SELECT
  date,
  client,
  support,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY date, client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY date, client) AS proportion
FROM
  fonts
GROUP BY
  date,
  client,
  support
ORDER BY
  date,
  client,
  support,
  proportion DESC
