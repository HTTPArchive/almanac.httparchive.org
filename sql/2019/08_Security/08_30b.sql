#standardSQL
# 08_30b: Groupings of "x-xss-protection" parsed values buckets
#    Inactive = 0
#    Active = 1 (.*)
#    Mode Block = 1 + mode=block
#    Reporting = 1 + report=
#    Active Block Reporting (combo of all 3)     
# 
#   Pct are against all FirstHTML responses
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 0')) * 100 / COUNT(0),2) AS pct_inactive,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 1')) * 100 / COUNT(0),2) AS pct_active,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 1.*mode=block.*')) * 100 / COUNT(0),2) AS pct_block,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 1.*report=.*')) * 100 / COUNT(0),2) AS pct_reporting,
  ROUND(COUNTIF(
    REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 1.*report=.*')
    and 
    REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = 1.*mode=block.*')
  ) * 100 / COUNT(0),2) AS pct_active_block_reporting
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
