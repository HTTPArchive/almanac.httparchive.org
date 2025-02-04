#standardSQL
# 06_43: Top color font formats
SELECT
  client,
  format,
  COUNT(0) AS freq,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct_pages
FROM
  `httparchive.almanac.requests`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client),
  # Color fonts have any of sbix, cbdt, svg or colr tables.
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(sbix|cbdt|svg|colr)')) AS format
WHERE
  date = '2019-07-01' AND
  type = 'font'
GROUP BY
  client,
  total,
  format
ORDER BY
  freq / total DESC
