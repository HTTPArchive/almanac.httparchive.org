#standardSQL
# 17_09: Count of sites with server-timing header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS serverTiming
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "server-timing") > 0
GROUP BY
  client


