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
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    opentype
)

SELECT
  client,
  COUNTIF(opentype) AS count,
  SUM(COUNTIF(opentype)) OVER (PARTITION BY client) AS total,
  COUNTIF(opentype) / SUM(COUNTIF(opentype)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client
ORDER BY
  client,
  proportion DESC
