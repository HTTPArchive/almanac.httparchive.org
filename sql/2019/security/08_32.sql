#standardSQL
# 08_32: Groupings of "cross-origin-resource-policy" values
SELECT
  client,
  policy,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), r'cross-origin-resource-policy = ([^,\r\n]+)')) AS policy
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  policy
ORDER BY
  freq / total DESC
