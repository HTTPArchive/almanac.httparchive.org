#standardSQL
#color_fonts
WITH
fonts AS (
  SELECT
    url,
    JSON_EXTRACT(payload, '$._font_details.color.formats') AS payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    payload
)
SELECT
  format,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_freq
FROM
  fonts,
  # Color fonts have any of sbix, cbdt, svg, colrv0 or colrv1 tables.
  UNNEST(REGEXP_EXTRACT_ALL(payload, '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)')) AS format
GROUP BY
  format
ORDER BY
  pct_freq DESC
