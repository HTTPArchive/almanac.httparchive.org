#standardSQL
# 08_31: Groupings of "x-frame-options" parsed values buckets
#    Total X-Frame-Options applied
#    Deny = deny
#    SameOrigin = sameorigin
#    AllowFrom = allow-from http(s)...
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-frame-options =')) / COUNT(0) AS pct_TotXFrames,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-frame-options = deny')) / COUNT(0) AS pct_Deny,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-frame-options = sameorigin')) / COUNT(0) AS pct_SameOrigin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-frame-options = allow-from http')) / COUNT(0) AS pct_AllowFrom
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
