#standardSQL
# 17_07: Count of sites with via header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS via
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "via") > 0
GROUP BY
  client
