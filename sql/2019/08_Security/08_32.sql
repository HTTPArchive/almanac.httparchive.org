#standardSQL
# 08_32: Groupings of "cross-origin-resource-policy" dynamically parsed values buckets
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  xcors_val,
  count(0) as xcors_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as xcors_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'cross-origin-resource-policy = ([^,\r\n]+)')) AS xcors_val
WHERE
  firstHtml
GROUP BY
  client, xcors_val
ORDER BY
  client, xcors_val_freq DESC
