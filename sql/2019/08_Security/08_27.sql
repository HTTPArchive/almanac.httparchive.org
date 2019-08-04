#standardSQL
# 08_29: Groupings of "referrer-policy" parsed values buckets
#   8 groups
#    no-referrer = does not contain "-when-downgrade"
#    no-referrer-when-downgrade
#    origin  = does not contain "-when-cross-origin"
#    origin-when-cross-origin
#    same-origin
#    strict-strict = does not contain "-origin-when-cross-origin"
#    strict-strict-origin-when-cross-origin
#    unsafe-url
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy =')) / COUNT(0) AS pct_TotXFrames,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = no-referrer[^-]')) / COUNT(0) AS pct_NoRef,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = no-referrer-when-downgrade')) / COUNT(0) AS pct_NoRefDowngrade,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = origin[^-]')) / COUNT(0) AS pct_Origin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = origin-when-cross-origin')) / COUNT(0) AS pct_OriginXOrigin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = same-origin')) / COUNT(0) AS pct_SameOrigin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = strict-strict[^-]')) / COUNT(0) AS pct_StrictOrigin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = strict-strict-origin-when-cross-origin')) / COUNT(0) AS pct_StrictOriginXOrigin,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = unsafe-url')) / COUNT(0) AS pct_UnsafeUrl
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
