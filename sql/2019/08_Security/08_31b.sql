#standardSQL
# 08_31b: Groupings of "x-frame-options" parsed values buckets
#    Total X-Frame-Options applied
#    Deny = deny
#    SameOrigin = sameorigin
#    AllowFrom = allow-from http(s)...
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client,
  COUNT(0) AS tot_count,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-frame-options =')) * 100 / COUNT(0),2) AS pct_t_x_frames,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-frame-options = deny')) * 100 / COUNT(0),2) AS pct_deny,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-frame-options = sameorigin')) * 100 / COUNT(0),2) AS pct_same_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-frame-options = allow-from http')) * 100 / COUNT(0),2) AS pct_allow_from
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client
