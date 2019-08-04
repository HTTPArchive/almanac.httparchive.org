#standardSQL
# 08_32: Groupings of "cross-origin-resource-policy" parsed values buckets
#    Total tagged
#    Same-Site
#    Same-Origin
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)cross-origin-resource-policy =')) / COUNT(0) AS pct_TotCORP,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)cross-origin-resource-policy = same-site')) / COUNT(0) AS pct_SameSite,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)cross-origin-resource-policy = same-origin')) / COUNT(0) AS pct_SameOrigin
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
