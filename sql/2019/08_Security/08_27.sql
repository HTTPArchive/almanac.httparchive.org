#standardSQL
# 08_27: Groupings of "referrer-policy" parsed values buckets
#   raw values pull from the header 
# 
#   `httparchive.summary_requests.2019_07_01_*`,` = 118.3 GB                            
SELECT
  _TABLE_SUFFIX AS client,
  policy,
  COUNT(0) as freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) as pct 
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), 'referrer-policy = ([\\w-]+)')) AS policy
WHERE
  firstHtml
GROUP BY
  client,
  policy
ORDER BY
  freq / total DESC
