WITH
fonts AS (
  SELECT
    client,
    url,
    JSON_EXTRACT(payload, '$._font_details.table_sizes') AS payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    payload
)
SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM
  fonts,
  UNNEST(REGEXP_EXTRACT_ALL(payload, '(?i)(CFF |glyf|SVG|CFF2)')) AS format
GROUP BY
  client,
  format
ORDER BY
  pct_freq DESC
