-- Section: Development
-- Question: How prevalent is OpenType support?

WITH
fonts AS (
  SELECT
    client,
    url,
    REGEXP_CONTAINS(
      JSON_EXTRACT(payload, '$._font_details.table_sizes'),
      '(?i)GPOS|GSUB'
    ) AS opentype
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    opentype
)

SELECT
  client,
  opentype,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  opentype
ORDER BY
  client,
  opentype,
  proportion DESC
