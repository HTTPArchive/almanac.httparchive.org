#standardSQL
# 08_27: Groupings of "referrer-policy" parsed values buckets
#   8 groups
#    no-referrer = does not contain "-when-downgrade"
#    no-referrer-when-downgrade
#    origin  = does not contain "-when-cross-origin"
#    origin-when-cross-origin
#    same-origin
#    strict-strict = does not contain "-origin-when-cross-origin"
#    strict-strict-origin-when-cross-origin
#    unsafe-url
#    Pct is based on ALL firstHTML response for now
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy =')) * 100 / COUNT(0),2) AS pct_tot_x_frames,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = no-referrer[^-]')) * 100 / COUNT(0),2) AS pct_no_ref,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = no-referrer-when-downgrade')) * 100 / COUNT(0),2) AS pct_no_ref_downgrade,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = origin[^-]')) * 100 / COUNT(0),2) AS pct_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = origin-when-cross-origin')) * 100 / COUNT(0),2) AS pct_origin_x_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = same-origin')) * 100 / COUNT(0),2) AS pct_same_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = strict-strict[^-]')) * 100 / COUNT(0),2) AS pct_strict_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = strict-strict-origin-when-cross-origin')) * 100 / COUNT(0),2) AS pct_strict_origin_x_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = unsafe-url')) * 100 / COUNT(0),2) AS pct_unsafe_url
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
