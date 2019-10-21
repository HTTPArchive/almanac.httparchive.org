#standardSQL
# 04_01: Lighthouse media scores, savings, and item lengths

SELECT
  count(0) as PageCount,
  APPROX_QUANTILES(totalImageCount, 1000)[OFFSET(100)] AS count_p10,
  APPROX_QUANTILES(totalImageCount, 1000)[OFFSET(250)] AS count_p25,
  APPROX_QUANTILES(totalImageCount, 1000)[OFFSET(500)] AS count_p50,
  APPROX_QUANTILES(totalImageCount, 1000)[OFFSET(750)] AS count_p75,
  APPROX_QUANTILES(totalImageCount, 1000)[OFFSET(900)] AS count_p90,
  APPROX_QUANTILES(totalImageBytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(totalImageBytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(totalImageBytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(totalImageBytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(totalImageBytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(round(100*totalImageBytes/(totalBytes + 0.1), 2), 1000)[OFFSET(100)] AS pct_p10,
  APPROX_QUANTILES(round(100*totalImageBytes/(totalBytes + 0.1), 2), 1000)[OFFSET(250)] AS pct_p25,
  APPROX_QUANTILES(round(100*totalImageBytes/(totalBytes + 0.1), 2), 1000)[OFFSET(500)] AS pct_p50,
  APPROX_QUANTILES(round(100*totalImageBytes/(totalBytes + 0.1), 2), 1000)[OFFSET(750)] AS pct_p75,
  APPROX_QUANTILES(round(100*totalImageBytes/(totalBytes + 0.1), 2), 1000)[OFFSET(900)] AS pct_p90
FROM
(
  SELECT
    url,
    cast(json_extract_scalar(report, '$.audits.resource-summary.details.items[0].size') AS INT64) totalBytes,
    cast(json_extract_scalar(report, '$.audits.resource-summary.details.items[1].size') AS INT64) totalImageBytes,
    cast(json_extract_scalar(report, '$.audits.resource-summary.details.items[1].requestCount') AS INT64) totalImageCount
  FROM
    `httparchive.almanac.lighthouse_mobile_1k`
)
