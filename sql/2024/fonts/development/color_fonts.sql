#standardSQL
#color_fonts
WITH
fonts AS (
  SELECT
    url,
    client,
    JSON_EXTRACT(payload, '$._font_details.color.formats') AS payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    client,
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
  # Color fonts have any of sbix, cbdt, svg, colrv0 or colrv1 tables.
  UNNEST(REGEXP_EXTRACT_ALL(payload, '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)')) AS format
GROUP BY
  client,
  format
ORDER BY
  pct_freq DESC
