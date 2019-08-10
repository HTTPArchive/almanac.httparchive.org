#standardSQL
# 17_11: Count of sites with content-disposition header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS vary
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "content-disposition") > 0
GROUP BY
  client
