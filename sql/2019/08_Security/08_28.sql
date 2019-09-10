#standardSQL
# 08_28: Groupings of "feature-policy" parsed values buckets
#
#
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
 
SELECT
  _TABLE_SUFFIX AS client,
  policy,
  COUNT(0) as freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) as pct 
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), 'feature-policy = ([\\w-]+)')) AS value,
  UNNEST(SPLIT(value, ';')) AS policy
WHERE
  firstHtml
GROUP BY
  client,
  policy
ORDER BY
  freq / total DESC
