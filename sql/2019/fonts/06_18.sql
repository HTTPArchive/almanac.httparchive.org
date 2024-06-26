#standardSQL
# 06_18-19: % of pages that include a variable font
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
  JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.gvar') IS NOT NULL
GROUP BY
  client,
  total
