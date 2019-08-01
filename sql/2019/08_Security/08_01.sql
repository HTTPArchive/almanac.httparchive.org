/*
standard SQL
08_01

Calculate usage percentage for each of the 10 metrics

BigQuery usage notes: 
 == archive.summary_response_bodies =  71.5 GB usage
 */

SELECT
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)nel =')) / COUNT(0) AS pct_NEL,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)report-to = ')) / COUNT(0) AS pct_ReportTo,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)referrer-policy = ')) / COUNT(0) AS pct_ReferrerPolicy,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)feature-policy = ')) / COUNT(0) AS pct_FeaturePolicy,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-content-type-options = ')) / COUNT(0) AS pct_XContentTypeOptions,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-xss-protection = ')) / COUNT(0) AS pct_XXssProtection,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)x-frame-options = ')) / COUNT(0) AS pct_XFrameOptions,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)cross-origin-response-policy = ')) / COUNT(0) AS pct_XOriginResponsePolicy,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)cross-origin-opener-policy = ')) / COUNT(0) AS pct_XOriginOpenerPolicy,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), '(?i)sec-fetch-%:')) / COUNT(0) AS pct_SecFetch
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
