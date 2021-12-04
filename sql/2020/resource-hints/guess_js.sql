#standardSQL
# 21_05: Usage of Guess.js
SELECT
  client,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(body, r'__GUESS__'), page, NULL)) AS guess,
  COUNT(0) AS total,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(body, r'__GUESS__'), page, NULL)) / COUNT(0) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  date = '2020-08-01' AND
  type = 'script'
GROUP BY
  client
