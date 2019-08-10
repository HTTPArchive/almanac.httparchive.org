#standardSQL
# 17_05: Count of sites with strict-transport-security header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS strictTransportSecurity
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "strict-transport-security") > 0
GROUP BY
  client