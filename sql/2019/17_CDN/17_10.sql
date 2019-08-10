#standardSQL
# 17_10: Count of sites with vary header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS vary
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "vary") > 0
GROUP BY
  client
