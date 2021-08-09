#standardSQL
#color_fonts
SELECT
  client,
  format,
  COUNT(DISTINCT page) AS pages_color,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_color
FROM (
  SELECT
    client,
    page,
    format,
    payload
  FROM
    `httparchive.almanac.requests`
  WHERE
     date = '2020-09-01' AND
     type = 'font')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_09_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client),
  # Color fonts have any of sbix, cbdt, svg or colr tables.
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(sbix|CBDT|SVG|COLR)')) AS format
GROUP BY
  client,
  total_page,
  format
ORDER BY
  pages_color DESC
