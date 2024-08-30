-- Section: Development
-- Question: How prevalent is OpenType support?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    client,
    url,
    REGEXP_CONTAINS(
      JSON_EXTRACT(payload, '$._font_details.table_sizes'),
      '(?i)GPOS|GSUB'
    ) AS support
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    support
)

SELECT
  client,
  support,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  support
ORDER BY
  client,
  support,
  proportion DESC
