#standardSQL
# 17_11: Percentage of responses with content-disposition header
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(LOWER(respOtherHeaders) LIKE "%content-disposition%") AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(LOWER(respOtherHeaders) LIKE "%content-disposition%") * 100 / COUNT(0), 2) AS pct
FROM 
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
