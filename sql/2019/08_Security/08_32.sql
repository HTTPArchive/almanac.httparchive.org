#standardSQL
# 08_32: Groupings of "cross-origin-resource-policy" parsed values buckets
#    Total tagged
#    Same-Site
#    Same-Origin
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS tot_count,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-resource-policy =')) * 100 / COUNT(0),2) AS pct_tot_corp,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-resource-policy = same-site')) * 100 / COUNT(0),2) AS pct_same_site,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-resource-policy = same-origin'))* 100 / COUNT(0),2) AS pct_same_origin,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-resource-policy = cross-site'))* 100 / COUNT(0),2) AS pct_same_cross_site
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
