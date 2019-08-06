#standardSQL
# 08_28: Groupings of "feature-policy" parsed values buckets

#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
 
SELECT
  policy,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'feature-policy = ([^,\r\n]+)')) AS value,
  UNNEST(SPLIT(value, ';')) AS policy
WHERE
  firstHtml
GROUP BY
  policy
ORDER BY
  freq DESC
