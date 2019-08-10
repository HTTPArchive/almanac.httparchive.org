#standardSQL
# 17_06: Count of sites with timing-allow-origin header
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(respOtherHeaders) AS timingAllowOrigin
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE
   STRPOS(LOWER(respOtherHeaders), "timing-allow-origin") > 0
GROUP BY
  client
