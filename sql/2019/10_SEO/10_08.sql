#standardSQL

# Status codes returned

SELECT
  status,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`
WHERE
  firstReq
GROUP BY
  status
ORDER BY
  freq DESC
