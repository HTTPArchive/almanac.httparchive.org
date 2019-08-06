
#standardSQL
# 08_33: Groupings of "cross-origin-opener-policy" parsed values by percentage
#   Move to dynamic parsing for now
#    
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#       0 rows available some far
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
# 
#   break at "report=" to generalize
# 
#
#   Within "archive" I only see 3 buckets, "null", "allow-postmessage" and "same-origin"
#   I see references to "Deny", "Allow" in Safari. 

SELECT
  val,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'cross-origin-opener-policy = ([\\w-]+)')) AS val
WHERE
  firstHtml
GROUP BY
  val
ORDER BY
  freq DESC
