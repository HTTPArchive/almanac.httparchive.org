#standardSQL
# 17_05: Percentage of responses with strict-transport-security header
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(SUM(IF(LOWER(respOtherHeaders) LIKE "%strict-transport-security%", 1, 0)) / COUNT(0), 4) AS pctStrictTransportSecurity
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
