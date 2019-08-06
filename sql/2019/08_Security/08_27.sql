#standardSQL
# 08_27: Groupings of "referrer-policy" parsed values buckets
#   raw values pull from the header 
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  policy,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), 'referrer-policy = ([\\w-]+)')) AS policy
WHERE
  firstHtml
GROUP BY
  policy
ORDER BY
  freq DESC
