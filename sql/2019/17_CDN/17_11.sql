#standardSQL
# 17_11: Percentage of responses with content-disposition header
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(SUM(IF(LOWER(respOtherHeaders) LIKE "%content-disposition%", 1, 0)) / COUNT(0), 4) AS pctContentDisposition
FROM 
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
