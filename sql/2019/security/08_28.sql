#standardSQL
# 08_28: Groupings of "feature-policy" parsed values buckets
SELECT
  _TABLE_SUFFIX AS client,
  value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), 'feature-policy = ([^,]+)')) AS value
WHERE
  firstHtml
GROUP BY
  client,
  value
ORDER BY
  freq / total DESC
