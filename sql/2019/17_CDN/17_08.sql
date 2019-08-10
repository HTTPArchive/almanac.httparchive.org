#standardSQL
# 17_08: Count of sites with keep-alive header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS via
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "keep-alive") > 0
GROUP BY
  client
