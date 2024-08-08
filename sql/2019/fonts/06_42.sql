#standardSQL
# 06_42: % of pages that include a color font
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.requests`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  type = 'font' AND
  # Color fonts have any of sbix, cbdt, svg or colr tables.
  ARRAY_LENGTH(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(sbix|cbdt|svg|colr)')) > 0
GROUP BY
  client,
  total
