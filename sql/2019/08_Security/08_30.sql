#standardSQL
# 08_29: Groupings of "x-xss-protection" parsed values buckets
#    Inactive = 0
#    Active = 1 (.*)
#    Mode Block = 1 + mode=block
#    Reporting = 1 + report=
#    Active Block Reporting (combo of all 3)     
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  COUNT(0) AS TotCount,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 0')) / COUNT(0) AS pct_Inactive,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 1')) / COUNT(0) AS pct_Active,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 1.*mode=block.*')) / COUNT(0) AS pct_Block,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 1.*report=.*')) / COUNT(0) AS pct_Reporting,
  COUNTIF(
    REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 1.*report=.*')
    and 
    REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = 1.*mode=block.*')
  ) / COUNT(0) AS pct_ActiveBlockReporting
FROM
  `httparchive.almanac.summary_response_bodies`
  where firstHtml
