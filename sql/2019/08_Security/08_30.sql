#standardSQL
# 08_30: Groupings of "x-xss-protection" parsed values buckets
SELECT
  _TABLE_SUFFIX AS client,
  REPLACE(policy, ' ', '') AS policy,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), 'x-xss-protection = (0|1;\\s*mode=block|1;\\s*report=|1)')) AS policy
WHERE
  firstHtml
GROUP BY
  client,
  policy
ORDER BY
  freq / total DESC