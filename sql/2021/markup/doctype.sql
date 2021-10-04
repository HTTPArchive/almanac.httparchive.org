#standardSQL
# doctype

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(REGEXP_REPLACE(TRIM(doctype), r" +", " ")) AS doctype, # remove extra spaces and make lower case
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.summary_pages.2021_07_01_*`
GROUP BY
  client,
  doctype
ORDER BY
  client,
  freq DESC
LIMIT
100
