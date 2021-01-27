#standardSQL
# 10_08: HTTP status codes returned
SELECT
  client,
  status,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`
WHERE
  date = '2019-07-01' AND
  firstReq
GROUP BY
  client,
  status
ORDER BY
  freq / total DESC
