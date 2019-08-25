#standardSQL
# 17_05: Percentage of responses with strict-transport-security header
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(LOWER(respOtherHeaders) LIKE "%strict-transport-security%") AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(LOWER(respOtherHeaders) LIKE "%strict-transport-security%") * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
