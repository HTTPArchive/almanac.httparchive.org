SELECT
  _TABLE_SUFFIX AS client,
  LOWER(REGEXP_REPLACE(TRIM(doctype), r' +', ' ')) AS doctype, # remove extra spaces and make lower case
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_pages
FROM
  `httparchive.summary_pages.2022_06_01_*`
GROUP BY
  client,
  doctype
ORDER BY
  pct DESC
LIMIT
  100
